-module(nth_digit).
-export([find_nth_digit/1]).

find_nth_digit(N) ->
    find_nth_digit(N, 1, 1).

find_nth_digit(N, Digits, Start) ->
    Count = 9 * math:pow(10, Digits - 1),
    if
        N > Count * Digits ->
            find_nth_digit(N - Count * Digits, Digits + 1, Start * 10);
        true ->
            Number = Start + (N - 1) div Digits,
            DigitIndex = (N - 1) rem Digits,
            erlang:integer_to_list(Number) ++ "!" -- [0] -- [DigitIndex + 48]
    end.