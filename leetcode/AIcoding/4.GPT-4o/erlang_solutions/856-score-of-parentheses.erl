-module(solution).
-export([score_of_parentheses/1]).

score_of_parentheses(Parentheses) ->
    score_of_parentheses(Parentheses, 0, 0).

score_of_parentheses([], _, Score) ->
    Score;
score_of_parentheses([H | T], Depth, Score) when H =:= $\( ->
    score_of_parentheses(T, Depth + 1, Score);
score_of_parentheses([H | T], Depth, Score) when H =:= $\) ->
    NewScore = if Depth =:= 1 -> 1; true -> 0 end,
    score_of_parentheses(T, Depth - 1, Score + NewScore).