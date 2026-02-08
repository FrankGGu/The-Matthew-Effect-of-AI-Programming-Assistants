-module(solution).
-export([bestLocation/2]).

bestLocation(positions, distance) ->
    lists:foldl(fun({x1, y1}, {bestX, bestY, bestDist}) ->
        Dist = lists:foldl(fun({x2, y2}, Acc) -> 
            Acc + (abs(x1 - x2) + abs(y1 - y2)) 
        end, 0, positions),
        if 
            Dist < bestDist orelse bestDist == -1 ->
                {x1, y1, Dist};
            true ->
                {bestX, bestY, bestDist}
        end
    end, {0, 0, -1}, positions).