-module(solution).
-export([minAreaII/2]).

minAreaII(Matrix, Ones) ->
    {Xmin, Xmax, Ymin, Ymax} = find_bounds(Ones),
    (Xmin > Xmax orelse Ymin > Ymax) -> 0;
    (Xmax - Xmin + 1) * (Ymax - Ymin + 1).

find_bounds(Ones) ->
    lists:foldl(fun({X, Y}, {Xmin, Xmax, Ymin, Ymax}) ->
        {min(X, Xmin), max(X, Xmax), min(Y, Ymin), max(Y, Ymax)}
    end, {infinity, -infinity, infinity, -infinity}, Ones).