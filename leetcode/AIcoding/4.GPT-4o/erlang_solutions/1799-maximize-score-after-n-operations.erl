-module(solution).
-export([max_score/1]).

max_score(N) ->
    max_score_helper(N, 0, 1, 0).

max_score_helper(N, Score, Op, Acc) when Op =< N ->
    max_score_helper(N, Score + (Op * (Op + 1)) div 2, Op + 1, Acc + 1);
max_score_helper(_, Score, _, _) ->
    Score.