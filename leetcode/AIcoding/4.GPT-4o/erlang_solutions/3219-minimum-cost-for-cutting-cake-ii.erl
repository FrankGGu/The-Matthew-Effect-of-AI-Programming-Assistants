-module(solution).
-export([min_cost/2]).

min_cost(N, Cuts) ->
    SortedCuts = lists:sort(Cuts),
    Length = length(SortedCuts),
    min_cost_helper(SortedCuts, Length, N).

min_cost_helper(Cuts, Length, N) ->
    TotalCost = 0,
    MinCost = lists:foldl(fun(Cut, Acc) ->
        TotalCost1 = Acc + (Cut * (Length - 1)),
        Length1 = Length - 1,
        {TotalCost1, Length1}
    end, {0, Length}, Cuts),
    element(1, MinCost) * N + element(1, MinCost).