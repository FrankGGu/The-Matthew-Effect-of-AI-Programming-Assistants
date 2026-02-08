-spec divide(Dividend :: integer(), Divisor :: integer()) -> integer().
divide(Dividend, Divisor) ->
    if
        Dividend == -2147483648, Divisor == -1 -> 2147483647;
        true ->
            Sign = if
                (Dividend > 0) xor (Divisor > 0) -> -1;
                true -> 1
            end,
            Dvd = abs(Dividend),
            Dvs = abs(Divisor),
            Res = 0,
            loop(Dvd, Dvs, Res, Sign)
    end.

loop(Dvd, Dvs, Res, Sign) ->
    if
        Dvd < Dvs -> Res * Sign;
        true ->
            Temp = Dvs,
            Mul = 1,
            {NewDvs, NewMul} = inner_loop(Dvd, Temp, Mul),
            loop(Dvd - NewDvs, Dvs, Res + NewMul, Sign)
    end.

inner_loop(Dvd, Temp, Mul) ->
    if
        Temp bsl 1 > Dvd -> {Temp, Mul};
        true -> inner_loop(Dvd, Temp bsl 1, Mul bsl 1)
    end.