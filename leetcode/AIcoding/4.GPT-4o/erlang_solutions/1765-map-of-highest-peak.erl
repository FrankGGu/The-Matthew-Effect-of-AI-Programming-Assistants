-module(solution).
-export([highest_peak/1]).

highest_peak(Map) ->
    Width = length(Map),
    Height = length(hd(Map)),
    Peaks = lists:map(fun({X, Y}) -> {X, Y, find_peak(Map, X, Y, Width, Height)} end,
                      lists:filter(fun({_, _}) -> true end,
                                    lists:seq(0, Width - 1) ++ lists:seq(0, Height - 1))),
    Peaks.

find_peak(Map, X, Y, Width, Height) ->
    case lists:nth(X + 1, Map) of
        [] -> 0;
        Row -> case lists:nth(Y + 1, Row) of
            1 -> 0;
            _ -> lists:max([{find_peak(Map, X - 1, Y, Width, Height), find_peak(Map, X + 1, Y, Width, Height),
                             find_peak(Map, X, Y - 1, Width, Height), find_peak(Map, X, Y + 1, Width, Height)}]) + 1
        end
    end.