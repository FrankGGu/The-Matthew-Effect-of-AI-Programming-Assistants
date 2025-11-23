-module(solution).
-export([apply_operations/1]).

apply_operations(Str) ->
    apply_operations_helper(Str, []).

apply_operations_helper([], Acc) ->
    lists:reverse(Acc);
apply_operations_helper([H | T], Acc) when H =:= 0 ->
    apply_operations_helper(T, [H | Acc]);
apply_operations_helper([H | T], Acc) when H =:= 1 ->
    apply_operations_helper(T, Acc);
apply_operations_helper([H1, H2 | T], Acc) when H1 =:= 1, H2 =:= 1 ->
    apply_operations_helper(T, [0 | Acc]);
apply_operations_helper([H | T], Acc) ->
    apply_operations_helper(T, [H | Acc]).