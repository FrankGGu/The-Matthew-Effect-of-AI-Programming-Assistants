-module(solution).
-export([alternating_digit_sum/1]).

alternating_digit_sum(N) ->
    Digits = [X - $0 || X <- integer_to_list(N)],
    sum_digits_alternating(Digits, 1, 0).

sum_digits_alternating([], _Sign, Acc) ->
    Acc;
sum_digits_alternating([H|T], Sign, Acc) ->
    sum_digits_alternating(T, -Sign, Acc + H * Sign).