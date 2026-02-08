-module(solution).
-export([reverse/1]).

reverse(X) ->
    MaxInt = 2147483647,
    MinInt = -2147483648,

    case X of
        0 -> 0;
        _ ->
            Sign = if X < 0 -> -1; true -> 1 end,
            AbsX = abs(X),
            ReversedAbsX = reverse_positive(AbsX, 0),
            Result = Sign * ReversedAbsX,

            if
                Result > MaxInt -> 0;
                Result < MinInt -> 0;
                true -> Result
            end
    end.

reverse_positive(0, Acc) -> Acc;
reverse_positive(N, Acc) ->
    Digit = N rem 10,
    NewAcc = Acc * 10 + Digit,
    reverse_positive(N div 10, NewAcc).