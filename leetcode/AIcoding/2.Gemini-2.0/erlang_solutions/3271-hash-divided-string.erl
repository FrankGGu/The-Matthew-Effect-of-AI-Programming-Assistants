-module(hash_divided_string).
-export([solve/1]).

solve(S) ->
  solve(S, 0, 0, 0).

solve([], _, _, Count) ->
  Count;
solve([H|T], Hash1, Hash2, Count) ->
  NewHash1 = (Hash1 * 31 + H) rem 1000000007,
  NewHash2 = (Hash2 * 37 + H) rem 1000000007,
  if NewHash1 == NewHash2 ->
    solve(T, 0, 0, Count + 1)
  else
    solve(T, NewHash1, NewHash2, Count)
  end.