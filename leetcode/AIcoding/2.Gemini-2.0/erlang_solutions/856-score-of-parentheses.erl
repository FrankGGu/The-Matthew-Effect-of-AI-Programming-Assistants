-module(score_of_parentheses).
-export([score_of_parentheses/1]).

score_of_parentheses(S) ->
  score_of_parentheses(S, 0, []).

score_of_parentheses([], Acc, []) ->
  Acc;
score_of_parentheses([], Acc, [N|Rest]) ->
  score_of_parentheses([], Acc + N, Rest);
score_of_parentheses([$(|Rest], Acc, Stack) ->
  score_of_parentheses(Rest, Acc, [0|Stack]);
score_of_parentheses([$)|Rest], Acc, [0|Stack]) ->
  score_of_parentheses(Rest, Acc + 1, Stack);
score_of_parentheses([$)|Rest], Acc, [N|Stack]) ->
  score_of_parentheses(Rest, Acc, [2 * N|Stack]).