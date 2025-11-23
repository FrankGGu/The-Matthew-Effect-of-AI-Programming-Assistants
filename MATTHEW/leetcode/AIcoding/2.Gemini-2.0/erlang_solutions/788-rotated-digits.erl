-module(rotated_digits).
-export([rotatedDigits/1]).

rotatedDigits(N) ->
    lists:sum([if is_good(i) -> 1; true -> 0 end || i <- lists:seq(1, N)]).

is_good(N) ->
    is_good(N, false).

is_good(0, Changed) ->
    Changed;
is_good(N, Changed) ->
    Digit = N rem 10,
    case Digit of
        3 -> false;
        4 -> false;
        7 -> false;
        2 -> is_good(N div 10, true);
        5 -> is_good(N div 10, true);
        6 -> is_good(N div 10, true);
        9 -> is_good(N div 10, true);
        _ -> is_good(N div 10, Changed)
    end.