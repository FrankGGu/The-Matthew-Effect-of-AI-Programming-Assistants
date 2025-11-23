-module(solution).
-export([count_target_scores/2]).

count_target_scores(Scores, Target) ->
    lists:count(Target, Scores).