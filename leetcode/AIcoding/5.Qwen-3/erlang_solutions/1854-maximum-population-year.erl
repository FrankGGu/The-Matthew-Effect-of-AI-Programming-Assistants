-module(maximum_population_year).
-export([maximumPopulation/1]).

maximumPopulation(Parents) ->
    Births = lists:foldl(fun({B, _}, Acc) -> [B | Acc] end, [], Parents),
    Deaths = lists:foldl(fun({_, D}, Acc) -> [D | Acc] end, [], Parents),
    BirthsSorted = lists:sort(Births),
    DeathsSorted = lists:sort(Deaths),
    maxPopulation(BirthsSorted, DeathsSorted, 0, 0, 0, 0).

maxPopulation([], _, MaxYear, _, _, _) ->
    MaxYear;
maxPopulation(_, [], MaxYear, CurrentPop, _, _) ->
    if
        CurrentPop > 0 -> MaxYear;
        true -> 0
    end;
maxPopulation([B | Bs], [D | Ds], MaxYear, CurrentPop, MaxPop, Year) ->
    if
        B < D ->
            NewCurrentPop = CurrentPop + 1,
            NewMaxPop = if NewCurrentPop > MaxPop -> NewCurrentPop; true -> MaxPop end,
            NewYear = if NewCurrentPop > MaxPop -> B; true -> Year end,
            maxPopulation(Bs, [D | Ds], MaxYear, NewCurrentPop, NewMaxPop, NewYear);
        true ->
            NewCurrentPop = CurrentPop - 1,
            maxPopulation([B | Bs], Ds, MaxYear, NewCurrentPop, MaxPop, Year)
    end.