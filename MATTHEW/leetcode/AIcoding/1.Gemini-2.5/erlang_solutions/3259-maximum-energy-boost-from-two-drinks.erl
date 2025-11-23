-module(solution).
-export([maximumEnergyBoost/1]).

maximumEnergyBoost(Drinks) ->
    SortedDrinks = lists:sort(fun(A, B) -> A >= B end, Drinks),
    case SortedDrinks of
        [First, Second | _] ->
            First + Second;
        _ ->
            0
    end.