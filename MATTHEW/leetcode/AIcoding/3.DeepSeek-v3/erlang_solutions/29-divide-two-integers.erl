-spec divide(Dividend :: integer(), Divisor :: integer()) -> integer().
divide(Dividend, Divisor) ->
    MaxInt = 2147483647,
    MinInt = -2147483648,
    if 
        Divisor == 1 -> 
            if 
                Dividend > MaxInt -> MaxInt;
                Dividend < MinInt -> MinInt;
                true -> Dividend
            end;
        Divisor == -1 ->
            if 
                Dividend == MinInt -> MaxInt;
                true -> -Dividend
            end;
        true ->
            Negative = (Dividend > 0) xor (Divisor > 0),
            Dvd = abs(Dividend),
            Dvs = abs(Divisor),
            Result = 0,
            while_subtract(Dvd, Dvs, Negative, Result)
    end.

while_subtract(Dvd, Dvs, Negative, Result) ->
    if
        Dvd < Dvs -> 
            if 
                Negative -> -Result;
                true -> Result
            end;
        true ->
            Temp = Dvs,
            Mul = 1,
            {NewDvs, NewMul} = double_until_exceeds(Dvd, Temp, Mul),
            NewDvd = Dvd - NewDvs,
            NewResult = Result + NewMul,
            while_subtract(NewDvd, Dvs, Negative, NewResult)
    end.

double_until_exceeds(Dvd, Temp, Mul) ->
    if
        Temp =< (Dvd - Temp) ->
            double_until_exceeds(Dvd, Temp + Temp, Mul + Mul);
        true ->
            {Temp, Mul}
    end.