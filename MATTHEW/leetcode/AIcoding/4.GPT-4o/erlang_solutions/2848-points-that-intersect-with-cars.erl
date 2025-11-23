-module(solution).
-export([count_points/2]).

count_points(Cars, Points) ->
    PointsCount = lists:map(fun(Point) -> count_intersect(Cars, Point) end, Points),
    PointsCount.

count_intersect(Cars, Point) ->
    lists:foldl(fun({L, R}, Acc) ->
        if
            L =< Point, Point =< R -> Acc + 1;
            true -> Acc
        end
    end, 0, Cars).