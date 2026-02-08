-module(solution).
-export([maximum_score/3]).

maximum_score(A, B, C) ->
    maximum_score_helper(A, B, C, 0).

maximum_score_helper(0, 0, C, Score) -> 
    Score;
maximum_score_helper(A, B, C, Score) when A > 0, B > 0 ->
    maximum_score_helper(A - 1, B - 1, C + 1, Score + 1);
maximum_score_helper(A, B, C, Score) when A > 0, C > 0 ->
    maximum_score_helper(A - 1, B, C - 1, Score + 1);
maximum_score_helper(A, B, C, Score) when B > 0, C > 0 ->
    maximum_score_helper(A, B - 1, C - 1, Score + 1);
maximum_score_helper(A, B, C, Score) -> 
    Score.