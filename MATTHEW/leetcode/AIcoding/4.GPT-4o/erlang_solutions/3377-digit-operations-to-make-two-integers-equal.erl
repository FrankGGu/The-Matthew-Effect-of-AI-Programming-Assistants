-module(solution).
-export([min_operations/2]).

min_operations(A, B) ->
    A_digits = digit_list(A),
    B_digits = digit_list(B),
    lists:sum(lists:map(fun(X) -> abs(X) end, lists:zipwith(fun(X, Y) -> X - Y end, A_digits, B_digits))).

digit_list(0) -> [0];
digit_list(N) when N > 0 ->
    lists:reverse(digit_list(N div 10) ++ [N rem 10]).