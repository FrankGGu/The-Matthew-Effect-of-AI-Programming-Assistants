-module(isPrefixString).
-export([solve/2]).

solve(S, Words) ->
  solve(S, Words, "").

solve("", _, _) ->
  true;
solve(_, [], _) ->
  false;
solve(S, [H|T], Acc) ->
  NewAcc = Acc ++ H,
  case string:prefix(S, NewAcc) of
    true ->
      if S == NewAcc then
        true
      else
        solve(S, T, NewAcc)
      end;
    false ->
      false
  end.