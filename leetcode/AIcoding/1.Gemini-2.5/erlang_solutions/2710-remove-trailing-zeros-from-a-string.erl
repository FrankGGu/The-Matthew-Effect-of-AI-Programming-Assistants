-module(solution).
-export([removeTrailingZeros/1]).

removeTrailingZeros(Num) ->
    remove_trailing_zeros_recursive(lists:reverse(Num), []).

remove_trailing_zeros_recursive([], Acc) ->
    lists:reverse(Acc);
remove_trailing_zeros_recursive([$0 | T], []) -> % Only remove if we haven't started building the non-zero part
    remove_trailing_zeros_recursive(T, []);
remove_trailing_zeros_recursive([H | T], Acc) ->
    remove_trailing_zeros_recursive(T, [H | Acc]).