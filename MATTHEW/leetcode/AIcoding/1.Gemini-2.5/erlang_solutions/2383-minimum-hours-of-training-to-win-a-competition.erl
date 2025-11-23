-module(solution).
-export([min_training_hours/4]).

min_training_hours(InitialEnergy, InitialExperience, Energy, Experience) ->
    InitialState = {InitialEnergy, InitialExperience, 0},

    Battles = lists:zip(Energy, Experience),

    {_FinalEnergy, _FinalExperience, TotalTrainingHours} = 
        lists:foldl(
            fun({RequiredEnergy, RequiredExperience}, {CurrentE, CurrentX, TrainingH}) ->
                NeededEnergyTraining = 
                    case CurrentE =< RequiredEnergy of
                        true -> RequiredEnergy - CurrentE + 1;
                        false -> 0
                    end,

                NewCurrentE = CurrentE + NeededEnergyTraining,
                NewTrainingH_E = TrainingH + NeededEnergyTraining,

                NeededExperienceTraining = 
                    case CurrentX =< RequiredExperience of
                        true -> RequiredExperience - CurrentX + 1;
                        false -> 0
                    end,

                NewCurrentX = CurrentX + NeededExperienceTraining,
                NewTrainingH_Total = NewTrainingH_E + NeededExperienceTraining,

                UpdatedEnergyAfterBattle = NewCurrentE - RequiredEnergy,
                UpdatedExperienceAfterBattle = NewCurrentX + RequiredExperience,

                {UpdatedEnergyAfterBattle, UpdatedExperienceAfterBattle, NewTrainingH_Total}
            end,
            InitialState,
            Battles
        ),
    TotalTrainingHours.