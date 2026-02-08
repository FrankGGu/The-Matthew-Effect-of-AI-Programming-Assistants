-module(solution).
-export([countDigitOne/1]).

countDigitOne(N) when N < 0 -> 0;
countDigitOne(N) ->
    countDigitOne_recursive(N, 1, 0).

countDigitOne_recursive(N, K, Acc) when K > N ->
    Acc;
countDigitOne_recursive(N, K, Acc) ->
    Divisor = K * 10,
    A = N div Divisor,
    B = N rem Divisor,
    Digit = (N div K) rem 10,

    CurrentCount =
        case Digit of
            0 -> A * K;
            1 -> A * K + (B rem K) + 1;
            _ -> A * K + K
        end,

    NewAcc = Acc + CurrentCount,

    NextK = K * 10,
    countDigitOne_recursive(N, NextK, NewAcc).