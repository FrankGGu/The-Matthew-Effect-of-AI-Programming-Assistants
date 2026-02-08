-module(maximum_amount_money).
-export([solve/1]).

solve(N) ->
  solve(N, 0, 0).

solve(0, Acc, _) ->
  Acc;
solve(N, Acc, Last) ->
  if
    Last == 0 ->
      solve(N - 1, Acc + N, 1);
    true ->
      solve(N - 1, Acc + N, 0)
  end.