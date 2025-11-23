-module(solution).
-export([findNthDigit/1]).

findNthDigit(N) ->
    find_nth_digit_loop(N, 1, 9, 1).

find_nth_digit_loop(N, Digits, Count, Start) ->
    DigitsCount = Digits * Count,
    if
        N > DigitsCount ->
            find_nth_digit_loop(N - DigitsCount, Digits + 1, Count * 10, Start * 10);
        true ->
            TargetNum = Start + ((N - 1) div Digits),
            DigitIndex = (N - 1) rem Digits,
            NumStr = integer_to_list(TargetNum),
            CharDigit = lists:nth(DigitIndex + 1, NumStr),
            CharDigit - $0
    end.