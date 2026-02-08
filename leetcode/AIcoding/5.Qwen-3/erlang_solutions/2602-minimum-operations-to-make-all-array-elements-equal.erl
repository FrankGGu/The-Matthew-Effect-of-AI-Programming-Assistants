-module(min_operations).
-export([min_operations/1]).

min_operations(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Mid = lists:nth((N + 1) div 2, Sorted),
    lists:sum([abs(X - Mid) || X <- Sorted]).