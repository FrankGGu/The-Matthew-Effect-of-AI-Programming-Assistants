-module(solution).
-export([find_x_value/1]).

find_x_value(Array) ->
    lists:foldl(fun(X, {Count, Sum}) -> {Count + 1, Sum + X} end, {0, 0}, Array).