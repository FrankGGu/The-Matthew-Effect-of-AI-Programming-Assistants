-module(solution).
-export([coloredCells/1]).

coloredCells(N) ->
    N*N + (N-1)*(N-1).