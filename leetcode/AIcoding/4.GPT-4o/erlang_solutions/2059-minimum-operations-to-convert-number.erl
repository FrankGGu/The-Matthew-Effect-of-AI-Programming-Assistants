-module(solution).
-export([min_operations/2]).

min_operations(X, Y) ->
    min_operations(X, Y, 0).

min_operations(X, Y, Steps) when X == Y ->
    Steps;
min_operations(X, Y, Steps) when X > Y ->
    min_operations(X - 1, Y, Steps + 1);
min_operations(X, Y, Steps) when X < Y ->
    min_operations(X * 2, Y, Steps + 1).