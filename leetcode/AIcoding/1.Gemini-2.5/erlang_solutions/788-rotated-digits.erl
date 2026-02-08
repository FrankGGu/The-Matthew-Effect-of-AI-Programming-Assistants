-module(solution).
-export([rotatedDigits/1]).

rotatedDigits(N) ->
    rotatedDigits(N, 1, 0).

rotatedDigits(N, Current, Count) when Current =< N ->
    case is_good(Current, false) of
        true ->
            rotatedDigits(N, Current + 1, Count + 1);
        false ->
            rotatedDigits(N, Current + 1, Count)
    end;
rotatedDigits(_N, _Current, Count) ->
    Count.

is_good(0, HasDifferentRotator) ->
    HasDifferentRotator;
is_good(Num, HasDifferentRotator) ->
    Digit = Num rem 10,
    case Digit of
        0 -> is_good(Num div 10, HasDifferentRotator);
        1 -> is_good(Num div 10, HasDifferentRotator);
        8 -> is_good(Num div 10, HasDifferentRotator);
        2 -> is_good(Num div 10, true);
        5 -> is_good(Num div 10, true);
        6 -> is_good(Num div 10, true);
        9 -> is_good(Num div 10, true);
        _ -> false
    end.