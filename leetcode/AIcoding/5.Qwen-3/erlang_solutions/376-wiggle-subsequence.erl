-module(wiggle_subsequence).
-export([wiggle_max_length/1]).

wiggle_max_length([]) -> 0;
wiggle_max_length([_]) -> 1;
wiggle_max_length(List) ->
    Up = 1,
    Down = 1,
    wiggle_max_length(List, Up, Down).

wiggle_max_length([], Up, Down) -> max(Up, Down);
wiggle_max_length([H | T], Up, Down) ->
    case T of
        [] -> max(Up, Down);
        _ ->
            Next = hd(T),
            if
                H < Next ->
                    wiggle_max_length(T, Up + 1, Down);
                H > Next ->
                    wiggle_max_length(T, Up, Down + 1);
                true ->
                    wiggle_max_length(T, Up, Down)
            end
    end.