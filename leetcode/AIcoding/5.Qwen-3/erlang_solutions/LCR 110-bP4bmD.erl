-module(unique_paths).
-export([unique_paths/1]).

unique_paths(N) ->
    unique_paths(1, N, 1).

unique_paths(X, N, Acc) when X == N ->
    Acc;
unique_paths(X, N, Acc) ->
    unique_paths(X + 1, N, Acc * X).