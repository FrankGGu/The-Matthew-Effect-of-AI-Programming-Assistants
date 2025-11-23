-module(score_of_string).
-export([solve/1]).

solve(S) ->
  score(S, 0).

score([], Acc) ->
  Acc;
score([$0|T], Acc) ->
  score(T, Acc + 1);
score([_|T], Acc) ->
  score(T, Acc).