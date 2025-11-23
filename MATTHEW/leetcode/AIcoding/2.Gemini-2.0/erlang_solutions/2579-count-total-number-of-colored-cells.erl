-module(solution).
-export([colored_cells/1]).

colored_cells(N) ->
  N * N + (N - 1) * (N - 1).