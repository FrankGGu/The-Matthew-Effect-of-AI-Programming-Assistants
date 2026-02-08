-module(number_of_digit_one).
-export([count_digit_one/1]).

count_digit_one(N) ->
    count_digit_one(N, 0, 1).

count_digit_one(0, Acc, _) ->
    Acc;
count_digit_one(N, Acc, M) ->
    Digit = N rem 10,
    Remaining = N div 10,
    count_digit_one(Remaining, Acc + count_digit_one_digit(Digit, Remaining, M), M * 10).

count_digit_one_digit(0, _, _) ->
    0;
count_digit_one_digit(1, Remaining, M) ->
    Remaining * M + 1;
count_digit_one_digit(Digit, Remaining, M) ->
    M + Remaining * M.