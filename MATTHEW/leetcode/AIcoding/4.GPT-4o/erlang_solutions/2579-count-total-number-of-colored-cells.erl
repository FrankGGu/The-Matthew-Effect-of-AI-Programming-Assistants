-module(solution).
-export([countColoredCells/1]).

countColoredCells(N) ->
    N * N + (N - 1) * N.