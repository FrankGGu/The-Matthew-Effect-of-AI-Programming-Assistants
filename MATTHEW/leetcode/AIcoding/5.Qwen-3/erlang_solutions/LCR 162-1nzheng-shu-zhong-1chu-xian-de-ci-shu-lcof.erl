-module(num_1_appearances).
-export([count_digit_one/1]).

count_digit_one(N) ->
    count_digit_one(N, 0).

count_digit_one(0, Count) ->
    Count;
count_digit_one(N, Count) ->
    Digit = N rem 10,
    if
        Digit == 1 ->
            count_digit_one(N div 10, Count + 1);
        true ->
            count_digit_one(N div 10, Count)
    end.