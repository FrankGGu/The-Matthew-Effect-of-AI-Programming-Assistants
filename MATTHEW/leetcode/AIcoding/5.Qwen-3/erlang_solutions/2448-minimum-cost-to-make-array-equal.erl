-module(minimum_cost_to_make_array_equal).
-export([minCost/2]).

minCost(Nums, Cost) ->
    N = length(Nums),
    lists:foldl(fun(I, Acc) -> Acc + abs(lists:nth(I, Nums) - lists:nth(I, Nums)) * lists:nth(I, Cost) end, 0, lists:seq(1, N)).