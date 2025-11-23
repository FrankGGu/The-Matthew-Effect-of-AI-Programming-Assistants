-module(solution).
-export([escape_the_ghosts/2]).

escape_the_ghosts(Ghosts, Target) ->
    DistanceToTarget = euclidean_distance({0, 0}, Target),
    lists:all(fun(Ghost) -> euclidean_distance(Ghost, Target) > DistanceToTarget end, Ghosts).

euclidean_distance({X1, Y1}, {X2, Y2}) ->
    math:sqrt(math:pow(X2 - X1, 2) + math:pow(Y2 - Y1, 2)).