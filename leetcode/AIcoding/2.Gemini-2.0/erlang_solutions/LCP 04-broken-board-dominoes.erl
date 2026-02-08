-module(broken_board_dominoes).
-export([solve/2]).

solve(M, N, Removed) ->
  solve(M, N, Removed, []).

solve(M, N, Removed, Acc) ->
  NumRemoved = length(Removed),
  BoardSize = M * N,
  EmptySpaces = BoardSize - NumRemoved,
  if
    EmptySpaces rem 2 == 1 ->
      0;
    true ->
      EmptySpaces div 2
  end.