-module(divide_array_min_cost).
-export([minimum_cost/1]).

minimum_cost(Nums) ->
    lists:sort(Nums)
    .
minimum_cost(Nums) ->
    SortedNums = lists:sort(Nums),
    [A, B, C | _] = SortedNums,
    A + B + C.