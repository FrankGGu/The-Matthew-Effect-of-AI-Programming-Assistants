-module(minimum_impossible_or).
-export([solve/1]).

solve(Nums) ->
  solve(Nums, 1).

solve(Nums, Current) ->
  case lists:member(Current, Nums) of
    true ->
      solve(Nums, Current * 2);
    false ->
      Current
  end.