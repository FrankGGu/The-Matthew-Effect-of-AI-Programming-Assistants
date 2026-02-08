-module(solution).
-export([maximum_population_year/1]).

maximum_population_year(Logs) ->
    MinYear = 1950,
    MaxYear = 2050,

    PopulationChanges = lists:foldl(
        fun([Birth, Death], Acc) ->
            Acc1 = maps:update_with(Birth, fun(V) -> V + 1 end, 1, Acc),
            maps:update_with(Death, fun(V) -> V - 1 end, -1, Acc1)
        end,
        #{},
        Logs
    ),

    {_FinalPop, _MaxPop, MaxPopYear} = lists:foldl(
        fun(Year, {CurrentPop, MaxPopAcc, MaxPopYearAcc}) ->
            Change = maps:get(Year, PopulationChanges, 0),
            NewCurrentPop = CurrentPop + Change,
            if
                NewCurrentPop > MaxPopAcc ->
                    {NewCurrentPop, NewCurrentPop, Year};
                true ->
                    {NewCurrentPop, MaxPopAcc, MaxPopYearAcc}
            end
        end,
        {0, 0, MinYear},
        lists:seq(MinYear, MaxYear)
    ),
    MaxPopYear.