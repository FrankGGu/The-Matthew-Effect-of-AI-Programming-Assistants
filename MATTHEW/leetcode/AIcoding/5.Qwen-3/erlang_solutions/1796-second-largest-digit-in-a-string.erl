-module(solution).
-export([second_largest_digit/1]).

second_largest_digit(Str) ->
    Digits = [C || C <- Str, C >= $0, C =< $9],
    Sorted = lists:usort(lists:reverse(Digits)),
    case length(Sorted) of
        1 -> -1;
        _ -> lists:nth(2, Sorted)
    end.