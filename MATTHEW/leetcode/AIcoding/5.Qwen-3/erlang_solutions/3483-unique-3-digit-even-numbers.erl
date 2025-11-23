-module(unique_3_digit_even_numbers).
-export([findEvenNumbers/1]).

findEvenNumbers(_Digits) ->
    Digits = _Digits,
    Lists = lists:seq(0, 9),
    [A || A <- lists:seq(1,9), B <- Lists, C <- Lists, A /= B, A /= C, B /= C, C rem 2 == 0],
    Unique = lists:usort([A*100 + B*10 + C || A <- lists:seq(1,9), B <- lists:seq(0,9), C <- lists:seq(0,9), A /= B, A /= C, B /= C, C rem 2 == 0]),
    length(Unique).