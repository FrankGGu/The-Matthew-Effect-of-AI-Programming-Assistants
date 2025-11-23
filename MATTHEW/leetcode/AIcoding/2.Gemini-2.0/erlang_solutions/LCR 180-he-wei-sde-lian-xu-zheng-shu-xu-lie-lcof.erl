-module(file_combination).
-export([solve/1]).

solve(N) ->
  solve(N, []).

solve(0, Acc) ->
  [lists:reverse(Acc)];
solve(N, Acc) when N > 0 ->
  solve(N - 1, [0 | Acc]) ++ solve(N - 1, [1 | Acc]).