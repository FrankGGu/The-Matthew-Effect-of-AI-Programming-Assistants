-module(solution).
-export([min_operations/2]).

min_operations(X, Y) when X == Y ->
    0;
min_operations(X, Y) ->
    abs(X - Y).