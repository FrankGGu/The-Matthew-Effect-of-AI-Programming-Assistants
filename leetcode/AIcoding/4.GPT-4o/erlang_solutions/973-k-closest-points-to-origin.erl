-module(solution).
-export([k_closest/2]).

k_closest(Points, K) ->
    PointsSorted = lists:sort(fun({X1, Y1}, {X2, Y2}) ->
        case (X1 * X1 + Y1 * Y1) - (X2 * X2 + Y2 * Y2) of
            0 -> 0;
            N when N < 0 -> -1;
            _ -> 1
        end
    end, Points),
    lists:sublist(PointsSorted, K).