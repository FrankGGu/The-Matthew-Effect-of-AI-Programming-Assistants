-module(solution).
-export([solve/1]).

solve(S) ->
  solve(S, []).

solve([], Acc) ->
  lists:reverse(Acc);
solve([H|T], Acc) ->
  case is_vowel(H) of
    true ->
      solve(T, [H|Acc]);
    false ->
      solve(T, Acc)
  end.

is_vowel(Char) ->
  lists:member(Char, "aeiouAEIOU").