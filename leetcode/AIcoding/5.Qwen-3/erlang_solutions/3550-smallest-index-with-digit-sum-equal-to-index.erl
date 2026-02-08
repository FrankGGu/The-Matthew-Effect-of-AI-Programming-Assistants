-module(solution).
-export([digit_sum_equal_to_index/1]).

digit_sum_equal_to_index(Nums) ->
    digit_sum_equal_to_index(Nums, 0).

digit_sum_equal_to_index([], _) ->
    -1;
digit_sum_equal_to_index([N | Rest], Index) ->
    Sum = sum_digits(N),
    if
        Sum == Index ->
            Index;
        true ->
            digit_sum_equal_to_index(Rest, Index + 1)
    end.

sum_digits(N) ->
    sum_digits(N, 0).

sum_digits(0, Acc) ->
    Acc;
sum_digits(N, Acc) ->
    sum_digits(N div 10, Acc + (N rem 10)).