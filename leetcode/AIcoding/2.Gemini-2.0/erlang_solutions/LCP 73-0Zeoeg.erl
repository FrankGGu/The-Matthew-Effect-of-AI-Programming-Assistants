-module(solution).
-export([maximum_score/1]).

maximum_score(scores) ->
  maximum_score_helper(scores, 0).

maximum_score_helper([], Acc) ->
  Acc;
maximum_score_helper([H|T], Acc) ->
  maximum_score_helper(T, Acc + H).