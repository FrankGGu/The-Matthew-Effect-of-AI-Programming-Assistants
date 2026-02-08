-module(solution).
-export([check_if_bitwise_or_has_trailing_zeros/2]).

check_if_bitwise_or_has_trailing_zeros(Num1, Num2) ->
    (Num1 bor Num2) band 1 == 0.