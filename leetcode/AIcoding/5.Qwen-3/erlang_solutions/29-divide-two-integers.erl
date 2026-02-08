-module(divide_two_integers).
-export([divide/2]).

divide(Dividend, Divisor) ->
    case Divisor of
        0 -> 0;
        _ ->
            Sign = if (Dividend < 0) xor (Divisor < 0) -> -1; true -> 1 end,
            AbsDividend = abs(Dividend),
            AbsDivisor = abs(Divisor),
            Result = divide_abs(AbsDividend, AbsDivisor),
            case Sign of
                -1 -> -Result;
                _ -> Result
            end
    end.

divide_abs(A, B) when A < B -> 0;
divide_abs(A, B) ->
    Shift = floor(math:log(A / B, 2)),
    ShiftedB = B bsl Shift,
    if
        ShiftedB > A -> divide_abs(A, B);
        true ->
            Count = 1 bsl Shift,
            Count + divide_abs(A - ShiftedB, B)
    end.