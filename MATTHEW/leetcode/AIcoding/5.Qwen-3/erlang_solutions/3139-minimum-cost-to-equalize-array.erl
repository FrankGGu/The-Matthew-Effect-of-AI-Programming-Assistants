-module(minimum_cost_to_equalize_array).
-export([equalizeArray/1]).

equalizeArray(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Mid = N div 2,
    Median = lists:nth(Mid + 1, Sorted),
    lists:sum([abs(X - Median) || X <- Nums]).