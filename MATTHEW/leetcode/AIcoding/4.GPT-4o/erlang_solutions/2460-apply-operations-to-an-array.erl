-module(solution).
-export([apply_operations/1]).

apply_operations(Nums) ->
    apply_operations(Nums, [], 0).

apply_operations([], Acc, _) ->
    lists:reverse(Acc);
apply_operations([H | T], Acc, 0) ->
    apply_operations(T, [H | Acc], 0);
apply_operations([H, H2 | T], Acc, 1) when H == H2 ->
    apply_operations(T, [H * 2 | Acc], 0);
apply_operations([H | T], Acc, 1) ->
    apply_operations(T, [H | Acc], 0);
apply_operations([H | T], Acc, State) ->
    apply_operations(T, Acc, State + 1).