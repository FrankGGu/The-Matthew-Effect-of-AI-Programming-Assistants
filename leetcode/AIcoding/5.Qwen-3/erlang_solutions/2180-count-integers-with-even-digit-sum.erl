-module(solution).
-export([count_even_digit_sum/1]).

count_even_digit_sum(N) ->
    count_even_digit_sum(N, 0).

count_even_digit_sum(0, Count) ->
    Count;
count_even_digit_sum(I, Count) ->
    Digits = integer_to_list(I),
    Sum = lists:sum([list_to_integer([C]) || C <- Digits]),
    NewCount = case Sum rem 2 of
                   0 -> Count + 1;
                   _ -> Count
               end,
    count_even_digit_sum(I - 1, NewCount).