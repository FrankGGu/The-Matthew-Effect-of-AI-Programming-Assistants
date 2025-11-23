-module(solution).
-export([min_operations/2]).

min_operations(X, Y) ->
    min_operations(X, Y, 0).

min_operations(0, 0, Acc) ->
    Acc;
min_operations(X, Y, Acc) when X == Y ->
    Acc;
min_operations(X, Y, Acc) when X > Y ->
    min_operations(X - Y, Y, Acc + 1);
min_operations(X, Y, Acc) when Y > X ->
    min_operations(X, Y - X, Acc + 1).