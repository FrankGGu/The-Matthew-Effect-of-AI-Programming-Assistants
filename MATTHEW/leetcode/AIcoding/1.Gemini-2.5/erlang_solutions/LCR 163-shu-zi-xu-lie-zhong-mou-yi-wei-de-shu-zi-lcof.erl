-module(solution).
-export([findKthDigit/1]).

findKthDigit(K) ->
    find(K, 1, 9, 1).

find(K, Digits, Count, Start) ->
    TotalDigitsInBlock = Digits * Count,
    if
        K > TotalDigitsInBlock ->
            find(K - TotalDigitsInBlock, Digits + 1, Count * 10, Start * 10);
        true ->
            NumOffset = (K - 1) div Digits,
            Num = Start + NumOffset,

            DigitIndex = (K - 1) rem Digits,

            NumStr = integer_to_list(Num),

            list_to_integer([lists:nth(DigitIndex + 1, NumStr)])
    end.