-- H.E.V Mark V HUD replacement by soup587/Jess
-- Feel free to edit, use parts of code, just don't take full credit for it!!

if not host:isHost() then return end
local windowSize = client:getScaledWindowSize()
local _windowSize = windowSize

local hudColour = "#ceb100"

local alignments = {
  "upleft",
  "upmiddle",
  "upright",
  "middleleft",
  "middle",
  "middleright",
  "bottomleft",
  "bottommiddle",
  "bottomright"
}
--Anchor indexed from left to right, up to down
local function setPosAnchored(part,anchor,posx,posy,depth)
if type(posx) ~= "number" then
  error("Illegal argument to setPosAnchored: " .. type(posx))
end
  
if anchor == 1 then
  posx = posx
  posy = posy
elseif anchor == 2 then
  posx = (-windowSize.x * 0.5) + posx
  posy = posy
elseif anchor == 3 then
  posx = (-windowSize.x) + posx
  posy = posy
elseif anchor == 4 then
  posx = posx
  posy = (-windowSize.y * 0.5) + posy
elseif anchor == 5 then
  posx = (-windowSize.x * 0.5) + posx
  posy = (-windowSize.y * 0.5) + posy
elseif anchor == 6 then
  posx = (-windowSize.x) + posx
  posy = (-windowSize.y * 0.5) + posy
elseif anchor == 7 then
  posx = posx
  posy = (-windowSize.y) + posy
elseif anchor == 8 then
  posx = (-windowSize.x * 0.5) + posx
  posy = (-windowSize.y) + posy
elseif anchor == 9 then
  posx = (-windowSize.x) + posx
  posy = (-windowSize.y) + posy
end
return part:setPos(posx,posy,depth)
end

local function colourText(text,color)
return '{"text":"'..text..'","color":"'..color..'"}'
end

events.tick:register(function()
_windowSize = windowSize
windowSize = client:getScaledWindowSize()
end)

local multBG = textures:newTexture("Background",1,1)
:setPixel(0,0,0,0,0,0.125)

renderer:setRenderHUD(false)
local hud = models:newPart("HUD","HUD")

local crosshair = hud:newPart("Crosshair")
crosshair:newText("Crosshair Mark")
:setText(colourText("×",hudColour))
:setAlignment("CENTER")
setPosAnchored(crosshair,5,-0.5,3.5)

local quickbg = textures:newTexture("quickbg",1,1):setPixel(0,0,1,1,1,1)
local quickinfo = crosshair:newPart("Quick Info")
local quickHealth = quickinfo:newPart("Quick Health")
:setPos(8,0,0)
quickHealth:newSprite("QHealthBG")
:setTexture(quickbg)
:setColor(0,0,0,0.25)
:setSize(2,16)
:setPos(0,4.5,0)
local quickHealthBar = quickHealth:newSprite("QHealthBar")
:setTexture(quickbg)
:setColor(vectors.hexToRGB(hudColour):unpack(),0.75)
:setSize(1,15)
:setRot(0,0,180)
:setPos(-1.5,-11,-1)
local quickAmmo = quickinfo:newPart("Quick Ammo")
:setPos(-5,0,0)
quickAmmo:newSprite("QAmmoBG")
:setTexture(quickbg)
:setColor(0,0,0,0.25)
:setSize(2,16)
:setPos(0.25,4.5,0)
local quickAmmoBar = quickAmmo:newSprite("QAmmoBar")
:setTexture(quickbg)
:setColor(vectors.hexToRGB(hudColour):unpack(),0.75)
:setSize(1,15)
:setRot(0,0,180)
:setPos(-1.25,-11,-1)

local healthDisplay = hud:newPart("Health Display")
setPosAnchored(healthDisplay,7,-9,28)
healthDisplay:newSprite("HPBG")
:setTexture(multBG)
:setSize(58,20)
healthDisplay:newText("Health Text")
:setText(colourText("§l".."HEALTH",hudColour))
:setOpacity(0.75)
:setScale(0.5)
:setPos(-4,-12)
local hpText = healthDisplay:newText("Health Amount")
:setText(colourText(100,hudColour))
:setOpacity(0.75)
:setPos(-28,-6,0)
:setScale(1.5)

local armourDisplay = hud:newPart("Armour Display")
setPosAnchored(armourDisplay,7,-80,28)
armourDisplay:newSprite("STBG")
:setTexture(multBG)
:setSize(58,20)
armourDisplay:newText("Suit Text")
:setText(colourText("§l".."SUIT",hudColour))
:setOpacity(0.75)
:setScale(0.5)
:setPos(-4,-12)
local suitText = armourDisplay:newText("Suit Amount")
:setText(colourText(60,hudColour))
:setOpacity(0.75)
:setPos(-28,-6,0)
:setScale(1.5)

local ammoDisplay = hud:newPart("Ammo Display")
setPosAnchored(ammoDisplay,9,84,28)
ammoDisplay:newSprite("AMBG")
:setTexture(multBG)
:setSize(75,20)

ammoDisplay:newText("Ammo Text")
:setText(colourText("§l".."AMMO",hudColour))
:setOpacity(0.75)
:setScale(0.75,0.625,0.75)
:setPos(-5,-12)
local amText = ammoDisplay:newText("Ammo Display")
:setText(colourText(12,hudColour))
:setOpacity(0.75)
:setPos(-30,-6,0)
:setScale(1.5)
local amReserve = ammoDisplay:newText("Ammo Reserve Display")
:setText(119)
:setOpacity(0.75)
:setPos(-56,-11,0)
:setScale(0.75)

local ammoCapables = {
  ['tacz:modern_kinetic_gun'] = true
}

local ammoTypes = {
  ['tacz:45acp'] = {
    ['tacz:ump45'] = true,
    ['tacz:vector45'] = true
  },
  ['tacz:556x45'] = {
    ['tacz:m249'] = true,
    ['tacz:m16a1'] = 20,
    ['tacz:m4a1'] = 30
  },
  ['tacz:762x39'] = {
    ['tacz:ak47'] = 30
  },
  ['tacz:9mm'] = {
    ['tacz:glock_17'] = 17,
    ['tacz:cz75'] = 16,
    ['tacz:hk_mp5a5'] = 30,
    ['tacz:uzi'] = true
  },
  ['tacz:338'] = {
    ['tacz:ai_awp'] = 5
  },
  ['tacz:50bmg'] = {
    ['tacz:m95'] = true
  },
  ['tacz:357mag'] = {
    ['tacz:deagle_golden'] = true
  },
  ['tacz:50ae'] = {
    ['tacz:deagle'] = true
  },
  ['tacz:12g'] = {
    ['tacz:db_short'] = 2,
    ['tacz:db_long'] = 2,
    ['tacz:aa12'] = 8
  },
  ['tacz:rpg_rocket'] = {
    ['tacz:rpg7'] = true
  },
  ['tacz:308'] = {
    ['tacz:scar_h'] = true
  }
}
local antiChambers = {
  ['tacz:db_short'] = true,
  ['tacz:db_long'] = true,
  ['tacz:aa12'] = true,
  ['tacz:m249'] = true,
  ['tacz:rpg7'] = true,
  ['tacz:uzi'] = true
}

local pvars = {}
events.tick:register(function()
  pvars.health = player:getHealth()
  pvars.mhealth = player:getMaxHealth()
  pvars.absorption = player:getAbsorptionAmount()
  pvars.healthRatio = ((pvars.health/pvars.mhealth)*100) + ((pvars.absorption/20)*100)
  pvars.armor = player:getArmor()
  pvars.armorRatio = (pvars.armor/20)*100
  pvars.heldItem = player:getHeldItem()
  pvars.ammoCapable = false
  if ammoCapables[pvars.heldItem.id] then
    pvars.ammoCapable = true
  end
  pvars.antiChambered = false
  if antiChambers[pvars.heldItem.tag.GunId] then
    pvars.antiChambered = true
  end
  pvars.reserveCount = 0
  if pvars.ammoCapable then
    if pvars.heldItem.id == "tacz:modern_kinetic_gun" then
      for k,v in pairs(ammoTypes) do
        if v[pvars.heldItem.tag.GunId] ~= nil then
          pvars.ammoType = k
          pvars.clipSize = v[pvars.heldItem.tag.GunId]
          pvars.clipRatio = math.clamp(((pvars.heldItem.tag.GunCurrentAmmoCount+(pvars.antiChambered and 0 or pvars.heldItem.tag.HasBulletInBarrel))/pvars.clipSize)*100,0,100)
          break
        else
          pvars.ammoType = nil
        end
      end
      for i = 0,35 do
        local item = host:getSlot(i)
        if item.id == "tacz:ammo" and item.tag.AmmoId == pvars.ammoType then
          pvars.reserveCount = pvars.reserveCount + item:getCount()
        elseif item.id == "tacz:ammo_box" then
          if item.tag.AmmoId == pvars.ammoType then
            pvars.reserveCount = pvars.reserveCount + item.tag.AmmoCount
          end
        end
      end
    end
  end
end)

events.tick:register(function()
hpText:setText(colourText(math.round(pvars.healthRatio),hudColour))

armourDisplay:setVisible(pvars.armor > 0)
if pvars.armor > 0 then
  suitText:setText(colourText(pvars.armorRatio,hudColour))
end

quickHealthBar:setSize(1,pvars.healthRatio/6.5)

ammoDisplay:setVisible(pvars.ammoCapable)
quickAmmo:setVisible(pvars.ammoCapable)
if pvars.ammoCapable then
  quickAmmoBar:setSize(1,(pvars.clipRatio/6.5))
  amText:setText(colourText(pvars.heldItem.tag.GunCurrentAmmoCount + (pvars.antiChambered and 0 or pvars.heldItem.tag.HasBulletInBarrel),hudColour))
  if pvars.reserveCount < 2147483647 then
    amReserve:setText(colourText(pvars.reserveCount,hudColour))
  else
    amReserve:setText(colourText("∞",hudColour))
  end
end
end)

local chatHistory = ""
local chatOffset = 0

local chat = hud:newPart("Chat")
setPosAnchored(chat,4,-12,-64)
chatText = chat:newText("Chat Text")
:setScale(0.75)
:setWidth(180)

local sayText = chat:newText("Say Text")
:setScale(0.75)
:setText("Say : ")

local debugtext = hud:newText("debug")

local chatimer = 0 

events.chat_receive_message:register(function(raw,text)
local tableified = json.newBuilder():build():deserialize(text)

local formatted
if tableified.with and tableified.with[2] and tableified.with[2].text then
  local user = tableified.with[1].insertion
  local message = tableified.with[2].text
  formatted = (user ..": " ..message)
elseif tableified.extra and tableified.extra[1].text == "[lua] " then
  local user = tableified.extra[2].text
  local message = tableified.extra[4].text
  formatted = ("[LUA] " .. user ..": "..(type(message) == "string" and message or tostring(message)))
else
  local message = raw
  formatted = (message)
end

chatHistory = chatHistory .. formatted .. "\n"

chatOffset = chatOffset + (client.getTextDimensions((formatted),180,true).y+1)*0.75
chatText:setPos(nil,chatOffset)
chatText:setText(chatHistory)
chatText:setOpacity(1)
chatimer = 120
end)

local chatOpen = false
events.tick:register(function()
chatOpen = host:isChatOpen()
sayText:setVisible(chatOpen)
if chatOpen then
  chatText:setOpacity(1)
  chatimer = 20
  sayText:setText("Say : "..host:getChatText())
end
if chatimer > 0 then
  chatimer = chatimer - 1
  if chatimer < 10 then
    chatText:setOpacity(chatimer/10)
  end
end
end)

events.tick:register(function()
if _windowSize == windowSize then return end
setPosAnchored(crosshair,5,-0.5,3.5)
setPosAnchored(healthDisplay,7,-9,28)
setPosAnchored(ammoDisplay,9,84,28)
setPosAnchored(chat,4,-12,-64+chatOffset)
end)
