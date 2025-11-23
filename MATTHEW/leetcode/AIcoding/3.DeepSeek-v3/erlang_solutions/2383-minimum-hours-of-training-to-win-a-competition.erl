-spec min_number_of_hours(InitialEnergy :: integer(), InitialExperience :: integer(), Energy :: [integer()], Experience :: [integer()]) -> integer().
min_number_of_hours(InitialEnergy, InitialExperience, Energy, Experience) ->
    {TotalEnergy, TotalExperience} = lists:foldl(
        fun({E, Exp}, {AccEnergy, AccExp}) ->
            NewAccEnergy = AccEnergy - E,
            NewAccExp = if
                AccExp > Exp -> AccExp + Exp;
                true -> Exp + (Exp - AccExp) + 1
            end,
            {NewAccEnergy, NewAccExp}
        end,
        {InitialEnergy, InitialExperience},
        lists:zip(Energy, Experience)
    ),
    EnergyNeeded = if
        TotalEnergy > 0 -> 0;
        true -> 1 - TotalEnergy
    end,
    ExperienceNeeded = if
        InitialExperience > TotalExperience - InitialExperience -> 0;
        true -> (TotalExperience - InitialExperience) - (InitialExperience - 1)
    end,
    EnergyNeeded + ExperienceNeeded.