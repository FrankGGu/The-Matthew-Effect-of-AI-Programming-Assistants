-module(solution).
-export([maxManhattanDistance/3]).

maxManhattanDistance(X, Y, K) ->
    max_manhattan_distance(X, Y, K, length(X)).

max_manhattan_distance(X, Y, K, N) ->
    MaxX = lists:max(X),
    MinX = lists:min(X),
    MaxY = lists:max(Y),
    MinY = lists:min(Y),
    Dist = MaxX - MinX + MaxY - MinY,
    Dist + 2 * K.