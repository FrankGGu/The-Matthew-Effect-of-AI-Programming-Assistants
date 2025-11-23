-module(find_winner).
-export([find_the_winner/2]).

find_the_winner(N, K) ->
  solve(lists:seq(1, N), K, 0).

solve([Winner], _, _) ->
  Winner;
solve(Circle, K, Start) ->
  Len = length(Circle),
  IndexToRemove = (Start + K - 1) rem Len,
  {Left, [Removed | Right]} = lists:split(IndexToRemove, Circle),
  NewCircle = Right ++ Left,
  solve(NewCircle, K, IndexToRemove).