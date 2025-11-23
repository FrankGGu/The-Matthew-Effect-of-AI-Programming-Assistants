-module(solution).
-export([countPoints/2]).

countPoints(C, P) ->
    lists:map(fun({x, y, r}) ->
        lists:foldl(fun({px, py}, acc) ->
            if
                (px - x)^2 + (py - y)^2 =< r^2 -> acc + 1;
                true -> acc
            end
        end, 0, P)
    end, C).