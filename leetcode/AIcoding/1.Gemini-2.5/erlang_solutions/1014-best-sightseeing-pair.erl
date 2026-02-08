-module(solution).
-export([max_score/1]).

max_score(Values) when is_list(Values), length(Values) >= 2 ->
    [V0, V1 | Rest] = Values,
    InitialMaxIPlusValue = V0 + 0, % Corresponds to values[0] + 0
    InitialMaxScore = V0 + V1 + 0 - 1, % Score for the first pair (0, 1)
    % Start processing from the element at index 2
    max_score_helper(Rest, 2, InitialMaxIPlusValue, InitialMaxScore).

max_score_helper([], _Index, _MaxIPlusValue, CurrentMaxScore) ->
    CurrentMaxScore;
max_score_helper([H|T], Index, MaxIPlusValue, CurrentMaxScore) ->
    % Calculate score for the current 'j' (H at Index)
    ScoreForCurrentJ = MaxIPlusValue + (H - Index),
    % Update the overall maximum score found so far
    NewMaxScore = max(CurrentMaxScore, ScoreForCurrentJ),
    % Update the maximum (values[i] + i) seen so far, including the current element
    NewMaxIPlusValue = max(MaxIPlusValue, H + Index),
    % Recurse for the rest of the list
    max_score_helper(T, Index + 1, NewMaxIPlusValue, NewMaxScore).