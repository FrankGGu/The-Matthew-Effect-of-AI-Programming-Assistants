-module(solution).
-export([min_abs_diff/1]).

min_abs_diff(Nums) ->
    Total = lists:sum(Nums),
    N = length(Nums),
    Half = div(N, 2),
    Powerset = lists:seq(0, math:pow(2, N) - 1),
    Subsets = [get_subset(Nums, I) || I <- Powerset],
    ValidSubsets = [Subset || Subset <- Subsets, length(Subset) =:= Half],
    MinDiff = lists:min([abs(Total - 2 * lists:sum(Subset)) || Subset <- ValidSubsets]),
    MinDiff.

get_subset(Nums, I) ->
    lists:filter(fun({Idx, _}) -> (I band (1 bsl Idx)) > 0 end, lists:zip(lists:seq(0, length(Nums) - 1), Nums)).