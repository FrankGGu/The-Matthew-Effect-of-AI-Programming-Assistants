-module(solution).
-export([getHappyString/2]).

getHappyString(N, K) ->
    MaxHappyStrings = 3 * (1 bsl (N - 1)),
    if
        K > MaxHappyStrings ->
            "";
        true ->
            LimitForFirstChar = 1 bsl (N - 1),
            {FirstChar, AdjustedK} =
                if
                    K =< LimitForFirstChar -> {$a, K};
                    K =< 2 * LimitForFirstChar -> {$b, K - LimitForFirstChar};
                    true -> {$c, K - 2 * LimitForFirstChar}
                end,
            [FirstChar | find_suffix(N - 1, AdjustedK, FirstChar)]
    end.

find_suffix(0, _K, _LastChar) ->
    [];
find_suffix(Length, K, LastChar) ->
    LimitForNextChar = 1 bsl (Length - 1),
    {Char1, Char2} =
        case LastChar of
            $a -> {$b, $c};
            $b -> {$a, $c};
            $c -> {$a, $b}
        end,
    {NextChar, AdjustedKForNext} =
        if
            K =< LimitForNextChar -> {Char1, K};
            true -> {Char2, K - LimitForNextChar}
        end,
    [NextChar | find_suffix(Length - 1, AdjustedKForNext, NextChar)].