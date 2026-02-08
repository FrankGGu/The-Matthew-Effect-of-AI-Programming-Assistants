-module(minimum_moves_to_equal_array_elements_ii).
-export([minMoves2EqualArrayElements/1]).

minMoves2EqualArrayElements(Nums) ->
    Sorted = lists:sort(Nums),
    Mid = length(Sorted) div 2,
    Median = lists:nth(Mid + 1, Sorted),
    lists:sum([abs(X - Median) || X <- Sorted]).