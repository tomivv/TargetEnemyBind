local dungeonZones = {
    "Algeth'ar Academy",
    "Halls of Infusion",
    "Ruby Life Pools",
    "Neltharus",
    "Brackenhide Hollow",
    "The Azure Vault",
    "Ohn'ahran Plains",
    "Uldaman: Legacy of Tyr",
    "Court of Stars",
    "Halls of Valor",
    "Temple of the Jade Serpent",
    "Shadowmoon Burial Grounds",
}

local f = CreateFrame("Frame")

StaticPopupDialogs["CHANGE_KEYBIND"] = {
    text = "Hei, muistitko vaihtaa target bindisi? >:)",
    button1 = "Ok",
    timeout = 0,
    whileDead = true,
    hideOnEscape = true,
    preferredIndex = 3,
}

local function isZoneDungeon(zone)
    for index, value in ipairs(dungeonZones) do
        if value == zone then
            return true
        end
    end
    return false
end

local function checkBind(bind)
    for i = 1, GetNumBindings() do
        command, key1, key2 = GetBinding(i)
        if command == bind then
            -- MAKE NOTIFICATION TO CHANGE KEY BINDS
            if key2 then
                StaticPopup_Show ("CHANGE_KEYBIND")
            end
        end
    end
end

local function OnEvent(self, event, ...)
    DEFAULT_CHAT_FRAME:AddMessage("EVENT: "..event)
    if event == "ARENA_PREP_OPPONENT_SPECIALIZATIONS" then
        checkBind("TARGETNEARESTENEMY")
    end

    if event == "ZONE_CHANGED_NEW_AREA" then
        if isZoneDungeon(GetZoneText()) then
            checkBind("TARGETNEARESTENEMYPLAYER")
        end
    end
end

f:RegisterEvent("ZONE_CHANGED_NEW_AREA")
f:RegisterEvent("ARENA_PREP_OPPONENT_SPECIALIZATIONS")
f:SetScript("OnEvent", OnEvent)