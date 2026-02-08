-module(solution).
-export([minimum_score/3]).

minimum_score(N, A, B) ->
    MinA = lists:min(A),
    MaxA = lists:max(A),
    MinB = lists:min(B),
    MaxB = lists:max(B),
    MinB - MaxA + MinA - MaxB.