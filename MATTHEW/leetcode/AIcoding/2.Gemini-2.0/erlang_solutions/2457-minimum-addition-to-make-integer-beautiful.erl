-module(minimum_addition).
-export([minimum_addition/2]).

minimum_addition(N, K) ->
    minimum_addition_helper(N, K, 0).

minimum_addition_helper(N, K, Acc) ->
    Sum = sum_digits(N + Acc),
    if Sum =< K ->
        Acc;
    true ->
        Base = 10 - N rem 10,
        minimum_addition_helper(N + Base, K, Acc + Base)
    end.

sum_digits(N) ->
    sum_digits_helper(N, 0).

sum_digits_helper(0, Acc) ->
    Acc;
sum_digits_helper(N, Acc) ->
    sum_digits_helper(N div 10, Acc + (N rem 10)).