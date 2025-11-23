-module(nearest_point).
-export([nearestValidPoint/2]).

nearestValidPoint(X, Y, Points) ->
    nearestValidPoint(X, Y, Points, -1, infinity, 0).

nearestValidPoint(_, _, [], Index, _, _) ->
    Index;
nearestValidPoint(X, Y, [Point | Rest], BestIndex, MinDist, CurrentIndex) ->
    case isValid(X, Y, Point) of
        true ->
            Dist = manhattanDistance(X, Y, Point);
            case Dist < MinDist of
                true ->
                    nearestValidPoint(X, Y, Rest, CurrentIndex, Dist, CurrentIndex + 1);
                false ->
                    nearestValidPoint(X, Y, Rest, BestIndex, MinDist, CurrentIndex + 1)
            end;
        false ->
            nearestValidPoint(X, Y, Rest, BestIndex, MinDist, CurrentIndex + 1)
    end.

isValid(X, Y, [Px, Py]) ->
    X == Px orelse Y == Py.

manhattanDistance(X, Y, [Px, Py]) ->
    abs(X - Px) + abs(Y - Py).