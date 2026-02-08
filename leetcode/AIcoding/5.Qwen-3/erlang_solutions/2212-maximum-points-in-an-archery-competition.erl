-module(solution).
-export([maximumPoints/1]).

maximumPoints(Arrows) ->
    solve(Arrows, 0, 0, 0).

solve([], _, Max, _) -> Max;
solve([H | T], Index, Max, Current) ->
    Points = H * (Index + 1),
    NewCurrent = Current + Points,
    if
        NewCurrent > Max ->
            solve(T, Index + 1, NewCurrent, 0);
        true ->
            solve(T, Index + 1, Max, NewCurrent)
    end.