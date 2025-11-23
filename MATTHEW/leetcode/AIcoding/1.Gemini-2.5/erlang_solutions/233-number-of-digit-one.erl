-module(solution).
-export([countDigitOne/1]).

countDigitOne(N) ->
    count_digit_one_recursive(N, 1, 0).

count_digit_one_recursive(N, Factor, Acc) when Factor > N ->
    Acc;
count_digit_one_recursive(N, Factor, Acc) ->
    Divisor = Factor * 10,
    A = N div Divisor,
    B = N rem Divisor,

    NewAcc1 = Acc + (A * Factor),

    CurrentDigit = B div Factor,

    NewAcc2 = case CurrentDigit of
        1 -> NewAcc1 + (B rem Factor) + 1;
        _ when CurrentDigit > 1 -> NewAcc1 + Factor;
        _ -> NewAcc1
    end,

    count_digit_one_recursive(N, Factor * 10, NewAcc2).