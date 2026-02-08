-module(magic_chessboard).
-export([solve/1]).

solve(N) ->
  solve(N, 0, 0, 0).

solve(0, A, B, C) ->
  [A, B, C];
solve(N, A, B, C) ->
  solve(N-1, B+C, A+C, A+B).