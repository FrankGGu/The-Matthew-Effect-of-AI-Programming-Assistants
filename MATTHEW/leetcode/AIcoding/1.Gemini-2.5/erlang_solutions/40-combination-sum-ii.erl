-module(combination_sum2).
-export([combinationSum2/2]).

combinationSum2(Candidates, Target) ->
    SortedCandidates = lists:sort(Candidates),
    backtrack(SortedCandidates, Target, 0, []).

backtrack(_Candidates, 0, _StartIndex, CurrentCombination) ->
    [lists:reverse(CurrentCombination)]; % Found a combination, reverse and wrap in a list

backtrack(Candidates, RemainingTarget, StartIndex, _CurrentCombination) when RemainingTarget < 0; StartIndex >= length(Candidates) ->
    []; % Invalid path or no more options, return empty list of combinations

backtrack(Candidates, RemainingTarget, StartIndex, CurrentCombination) ->
    Len = length(Candidates),
    % Accumulate results by iterating from StartIndex
    recursive_loop(Candidates, RemainingTarget, StartIndex, StartIndex, CurrentCombination, [], Len).

recursive_loop(_Candidates, _RemainingTarget, CurrentLoopIndex, _StartIndexForDupCheck, _CurrentCombination, AccCombinations, Len) when CurrentLoopIndex >= Len ->
    AccCombinations; % All candidates processed for this level, return accumulated combinations
recursive_loop(Candidates, RemainingTarget, CurrentLoopIndex, StartIndexForDupCheck, CurrentCombination, AccCombinations, Len) ->
    Candidate = lists:nth(CurrentLoopIndex + 1, Candidates), % Get the current candidate (Erlang lists are 1-indexed for nth)

    % Duplicate check:
    % If CurrentLoopIndex is greater than StartIndexForDupCheck (meaning it's not the first element in this loop iteration)
    % AND the current candidate is the same as the previous one (Candidates[CurrentLoopIndex] == Candidates[CurrentLoopIndex-1]).
    ShouldSkip = (CurrentLoopIndex > StartIndexForDupCheck) andalso (lists:nth(CurrentLoopIndex, Candidates) == Candidate),

    NewAccCombinations = if ShouldSkip ->
                             AccCombinations; % Skip this duplicate element
                         RemainingTarget - Candidate >= 0 ->
                             % Include the current candidate and recurse
                             CombinationsFromIncluding = backtrack(Candidates, RemainingTarget - Candidate, CurrentLoopIndex + 1, [Candidate | CurrentCombination]),
                             CombinationsFromIncluding ++ AccCombinations; % Add results from this branch
                         true ->
                             AccCombinations % Candidate too large, no combinations from including it
                         end,

    % Continue to the next candidate (effectively exploring the path where the current candidate is excluded)
    recursive_loop(Candidates, RemainingTarget, CurrentLoopIndex + 1, StartIndexForDupCheck, CurrentCombination, NewAccCombinations, Len).