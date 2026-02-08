-module(solution).
-export([applyOperations/1]).

applyOperations(Nums) ->
    AfterOps = apply_operations_phase1(Nums),
    apply_operations_phase2(AfterOps).

apply_operations_phase1(Nums) ->
    lists:reverse(apply_operations_phase1_rec(Nums, [])).

apply_operations_phase1_rec([N1, N2 | Rest], Acc) when N1 == N2 ->
    apply_operations_phase1_rec([0 | Rest], [N1 * 2 | Acc]);
apply_operations_phase1_rec([N1, N2 | Rest], Acc) ->
    apply_operations_phase1_rec([N2 | Rest], [N1 | Acc]);
apply_operations_phase1_rec([N], Acc) ->
    [N | Acc];
apply_operations_phase1_rec([], Acc) ->
    Acc.

apply_operations_phase2(List) ->
    NonZeros = [X || X <- List, X /= 0],
    NumZeros = length(List) - length(NonZeros),
    Zeros = lists:duplicate(NumZeros, 0),
    NonZeros ++ Zeros.