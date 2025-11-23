-module(max_points_inside_the_square).
-export([maxPoints/2]).

maxPoints(Points, S) ->
    PointsSorted = lists:sort(Points),
    Max = 0,
    lists:foldl(fun(P, Acc) ->
        X = element(1, P),
        Y = element(2, P),
        Dist = max(abs(X), abs(Y)),
        if
            Dist < 1 -> Acc;
            true -> Acc + 1
        end
    end, Max, PointsSorted).