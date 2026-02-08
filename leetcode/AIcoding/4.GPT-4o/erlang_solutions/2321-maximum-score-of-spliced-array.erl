-module(solution).
-export([maximum_score/2]).

maximum_score(A, B) ->
    MaxA = lists:max(A),
    MaxB = lists:max(B),
    TotalA = lists:sum(A),
    TotalB = lists:sum(B),
    Score1 = TotalA + (MaxB - lists:sum(B)),
    Score2 = TotalB + (MaxA - lists:sum(A)),
    max(Score1, Score2).