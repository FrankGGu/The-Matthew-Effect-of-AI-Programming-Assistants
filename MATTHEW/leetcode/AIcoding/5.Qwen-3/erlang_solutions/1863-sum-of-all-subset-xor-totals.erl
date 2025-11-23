-module(solution).
-export([subset_xor_sum/1]).

subset_xor_sum(Nums) ->
    subset_xor_sum(Nums, 0).

subset_xor_sum([], Acc) ->
    Acc;
subset_xor_sum([H|T], Acc) ->
    subset_xor_sum(T, Acc + H),
    subset_xor_sum(T, Acc + (H bxor Acc)).