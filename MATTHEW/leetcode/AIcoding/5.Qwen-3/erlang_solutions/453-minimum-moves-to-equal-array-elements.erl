-module(min_moves_to_equal_array_elements).
-export([minMoves/1]).

minMoves(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Sum = lists:sum(Sorted),
    Min = hd(Sorted),
    Sum - Min * N.