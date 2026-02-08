-module(total_characters_i).
-export([solve/1]).

solve(S) ->
  solve(S, []).

solve([], Acc) ->
  length(Acc);
solve([H|T], Acc) ->
  case lists:member(H, Acc) of
    true ->
      solve(T, Acc);
    false ->
      solve(T, [H|Acc])
  end.