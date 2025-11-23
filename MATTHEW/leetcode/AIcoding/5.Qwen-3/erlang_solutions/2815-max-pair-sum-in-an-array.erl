-module(solution).
-export([max_pair_sum/1]).

max_pair_sum(Nums) ->
    Sorted = lists:sort(Nums),
    max_pair_sum(Sorted, 0).

max_pair_sum([], Acc) ->
    Acc;
max_pair_sum([A, B | T], Acc) ->
    max_pair_sum(T, max(A + B, Acc)).