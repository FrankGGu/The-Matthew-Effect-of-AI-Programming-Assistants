-module(solution).
-export([subset_xor_sum/1]).

subset_xor_sum(List) ->
    subset_xor_sum(List, 0).

subset_xor_sum([], Acc) ->
    Acc;
subset_xor_sum([H|T], Acc) ->
    Count = 1 bsl length(T),
    subset_xor_sum(T, Acc + (H * Count)).