-module(solution).
-export([twoCitySchedCost/1]).

twoCitySchedCost(Costs) ->
    SortedCosts = lists:sort(fun({_, A}, {_, B}) -> A - B end, Costs),
    N = length(Costs) div 2,
    TotalCost1 = lists:foldl(fun({CityA, Cost}, Acc) -> Acc + Cost end, 0, lists:sublist(SortedCosts, 1, N)),
    TotalCost2 = lists:foldl(fun({CityB, Cost}, Acc) -> Acc + Cost end, 0, lists:sublist(SortedCosts, N + 1, N)),
    TotalCost1 + TotalCost2.