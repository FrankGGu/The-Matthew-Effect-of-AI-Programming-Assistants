-module(solution).
-export([max_score/1]).

max_score(A) ->
    A0 = hd(A),
    A1 = hd(tl(A)),
    Rest = tl(tl(A)),

    InitialMaxAiPlusI = A0 + 0,

    InitialMaxOverallScore = A0 + A1 + 0 - 1,

    max_score_helper(Rest, 2, InitialMaxAiPlusI, InitialMaxOverallScore).

max_score_helper([], _J, _CurrentMaxAiPlusI, CurrentMaxScore) ->
    CurrentMaxScore;
max_score_helper([H|T], J, CurrentMaxAiPlusI, CurrentMaxScore) ->
    ScoreForJ = CurrentMaxAiPlusI + H - J,

    NewMaxScore = max(CurrentMaxScore, ScoreForJ),

    NewMaxAiPlusI = max(CurrentMaxAiPlusI, H + J),

    max_score_helper(T, J + 1, NewMaxAiPlusI, NewMaxScore).