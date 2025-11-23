-module(solution).
-export([min_rectangles_to_cover_points/2]).

min_rectangles_to_cover_points(Points, W) ->
    XCoords = lists:sort(lists:map(fun([X, _Y]) -> X end, Points)),
    solve(XCoords, W, 0).

solve([], _W, Count) ->
    Count;
solve([X | Rest], W, Count) ->
    NewCount = Count + 1,
    CoveredUntil = X + W,
    RemainingPoints = skip_covered(Rest, CoveredUntil),
    solve(RemainingPoints, W, NewCount).

skip_covered([], _CoveredUntil) ->
    [];
skip_covered([X | Rest], CoveredUntil) ->
    if
        X =< CoveredUntil ->
            skip_covered(Rest, CoveredUntil);
        true ->
            [X | Rest]
    end.