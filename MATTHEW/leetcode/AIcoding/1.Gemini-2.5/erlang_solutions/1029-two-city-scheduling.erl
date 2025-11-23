-module(solution).
-export([twoCitySchedCost/1]).

twoCitySchedCost(Costs) ->
    N = length(Costs) div 2,
    SortedCosts = lists:sort(fun([A1, B1], [A2, B2]) -> (A1 - B1) =< (A2 - B2) end, Costs),

    {FirstHalf, SecondHalf} = lists:split(N, SortedCosts),

    SumA = lists:foldl(fun([A, _], Acc) -> Acc + A end, 0, FirstHalf),
    SumB = lists:foldl(fun([_, B], Acc) -> Acc + B end, 0, SecondHalf),

    SumA + SumB.