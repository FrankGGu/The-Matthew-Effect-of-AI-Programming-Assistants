-module(divide_two_integers).
-export([divide/2]).

divide(Dividend, Divisor) ->
    sign(Dividend, Divisor, abs(Dividend), abs(Divisor), 0).

sign(Dividend, Divisor, AbsDividend, AbsDivisor, Acc) when AbsDividend < AbsDivisor ->
    case ((Dividend > 0) and (Divisor > 0)) or ((Dividend < 0) and (Divisor < 0)) of
        true ->
            min(Acc, 2147483647);
        false ->
            max(-Acc, -2147483648)
    end;
sign(Dividend, Divisor, AbsDividend, AbsDivisor, Acc) ->
    Shift = find_shift(AbsDividend, AbsDivisor);
    NewAcc = Acc + (1 bsl Shift);
    NewDividend = AbsDividend - (AbsDivisor bsl Shift);
    sign(Dividend, Divisor, NewDividend, AbsDivisor, NewAcc).

find_shift(Dividend, Divisor) ->
    find_shift_helper(Dividend, Divisor, 0).

find_shift_helper(Dividend, Divisor, Shift) when (Divisor bsl (Shift + 1)) > Dividend ->
    Shift;
find_shift_helper(Dividend, Divisor, Shift) ->
    find_shift_helper(Dividend, Divisor, Shift + 1).