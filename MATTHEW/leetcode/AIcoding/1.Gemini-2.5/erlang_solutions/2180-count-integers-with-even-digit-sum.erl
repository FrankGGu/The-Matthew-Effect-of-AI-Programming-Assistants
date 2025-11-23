-module(solution).
-export([countEvenDigitSum/1]).

digit_sum(0) -> 0;
digit_sum(N) -> (N rem 10) + digit_sum(N div 10).

countEvenDigitSum(Num) ->
    count_even_digit_sum_helper(1, Num, 0).

count_even_digit_sum_helper(Current, Max, Count) when Current > Max ->
    Count;
count_even_digit_sum_helper(Current, Max, Count) ->
    Sum = digit_sum(Current),
    NewCount = case Sum rem 2 of
                   0 -> Count + 1;
                   _ -> Count
               end,
    count_even_digit_sum_helper(Current + 1, Max, NewCount).