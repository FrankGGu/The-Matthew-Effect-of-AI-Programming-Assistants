-module(solution).
-export([max_points/2]).

max_points(PointList, SquareSize) ->
    Points = lists:map(fun({X, Y}) -> {X, Y} end, PointList),
    MaxPoints = lists:foldl(fun(Point, Acc) -> 
        Count = count_points_in_square(Point, Points, SquareSize),
        lists:max([Acc, Count])
    end, 0, Points),
    MaxPoints.

count_points_in_square({X, Y}, Points, SquareSize) ->
    lists:foldl(fun({PX, PY}, Acc) ->
        if
            PX >= X, PX =< X + SquareSize, PY >= Y, PY =< Y + SquareSize ->
                Acc + 1;
            true ->
                Acc
        end
    end, 0, Points).