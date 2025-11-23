-module(calculate_digit_sum_of_a_string).
-export([digit_sum/2]).

digit_sum(_, 0) -> "";
digit_sum(S, K) ->
    Digits = [lists:nth(I, S) || I <- lists:seq(1, length(S))],
    Sum = lists:foldl(fun(D, Acc) -> Acc + (D - $0) end, 0, Digits),
    digit_sum(integer_to_list(Sum), K - 1).