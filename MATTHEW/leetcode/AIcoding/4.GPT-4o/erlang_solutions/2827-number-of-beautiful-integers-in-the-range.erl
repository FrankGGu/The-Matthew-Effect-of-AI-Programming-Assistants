-module(solution).
-export([count_beautiful_integers/2]).

count_beautiful_integers(Lower, Upper) ->
    count(Lower, Upper, 0).

count(Lower, Upper, Count) when Lower > Upper -> 
    Count;
count(Lower, Upper, Count) ->
    case is_beautiful(Lower) of
        true -> count(Lower + 1, Upper, Count + 1);
        false -> count(Lower + 1, Upper, Count)
    end.

is_beautiful(N) -> 
    DigitSum = digit_sum(N),
    (DigitSum rem 2 == 0) andalso (N rem 3 == 0).

digit_sum(0) -> 0;
digit_sum(N) -> (N rem 10) + digit_sum(N div 10).