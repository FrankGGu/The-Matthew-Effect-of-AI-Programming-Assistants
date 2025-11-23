-module(minimize_max_of_array).
-export([minimize_max/1]).

minimize_max(Nums) ->
    Sorted = lists:sort(Nums),
    Len = length(Sorted),
    Mid = (Len + 1) div 2,
    lists:nth(Mid, Sorted).