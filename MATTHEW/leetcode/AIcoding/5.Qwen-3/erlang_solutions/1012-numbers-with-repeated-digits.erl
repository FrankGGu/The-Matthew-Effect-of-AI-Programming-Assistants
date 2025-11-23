-module(solution).
-export([num_2_digits/1]).

num_2_digits(N) ->
    Count = 0,
    Digits = erlang:integer_to_list(N),
    Length = length(Digits),
    Permutations = lists:seq(1, Length - 1),
    Total = lists:foldl(fun(L, Acc) -> Acc + count_without_repeats(L) end, 0, Permutations),
    Total + count_with_repeats(Digits, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0).

count_without_repeats(Length) ->
    case Length of
        1 -> 9;
        _ ->
            9 * lists:foldl(fun(I, Acc) -> Acc * (10 - I) end, 1, lists:seq(1, Length - 1))
    end.

count_with_repeats(Digits, Pos, Mask, Tight, LeadingZero, Num, Used, DigitsCount, DigitsUsed, DigitsMask) ->
    case Pos of
        L when L == length(Digits) ->
            1;
        _ ->
            MaxDigit = if
                Tight == 1 -> list_to_integer(string:sub_string(Digits, Pos + 1, Pos + 1));
                true -> 9
            end,
            Sum = 0,
            lists:foldl(fun(D, Acc) ->
                NewTight = if
                    Tight == 1 andalso D == MaxDigit -> 1;
                    true -> 0
                end,
                NewLeadingZero = if
                    LeadingZero == 1 andalso D == 0 -> 1;
                    true -> 0
                end,
                NewNum = if
                    LeadingZero == 1 andalso D == 0 -> Num;
                    true -> Num * 10 + D
                end,
                NewUsed = if
                    LeadingZero == 1 andalso D == 0 -> Used;
                    true -> Used bor (1 bsl D)
                end,
                NewDigitsCount = if
                    LeadingZero == 1 andalso D == 0 -> DigitsCount;
                    true -> DigitsCount + 1
                end,
                NewDigitsUsed = if
                    LeadingZero == 1 andalso D == 0 -> DigitsUsed;
                    true -> DigitsUsed + 1
                end,
                NewDigitsMask = if
                    LeadingZero == 1 andalso D == 0 -> DigitsMask;
                    true -> DigitsMask + (1 bsl D)
                end,
                if
                    (NewUsed band (1 bsl D)) /= 0 andalso NewLeadingZero == 0 -> Acc;
                    true -> Acc + count_with_repeats(Digits, Pos + 1, NewMask, NewTight, NewLeadingZero, NewNum, NewUsed, NewDigitsCount, NewDigitsUsed, NewDigitsMask)
                end
            end, Sum, lists:seq(0, MaxDigit))
    end.