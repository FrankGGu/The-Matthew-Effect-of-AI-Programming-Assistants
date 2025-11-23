-module(solution).
-export([combinationSum2/2]).

combinationSum2(Candidates, Target) ->
    SortedCandidates = lists:sort(Candidates),
    % Initial call: target, current sum 0, empty combination (built in reverse),
    % full list of remaining candidates, empty accumulator for results.
    Results = backtrack(Target, 0, [], SortedCandidates, []),
    % Reverse each combination in the results to get the correct order.
    [lists:reverse(C) || C <- Results].

backtrack(Target, CurrentSum, CurrentCombinationReversed, _RemainingCandidates, Acc) when CurrentSum == Target ->
    [CurrentCombinationReversed | Acc];

backtrack(Target, CurrentSum, _CurrentCombinationReversed, _RemainingCandidates, Acc) when CurrentSum > Target ->
    Acc;

backtrack(Target, CurrentSum, CurrentCombinationReversed, [Candidate | RestCandidates], Acc) ->
    % Option 1: Pick the current Candidate.
    NewSum = CurrentSum + Candidate,
    NewCombinationReversed = [Candidate | CurrentCombinationReversed], % Prepend is efficient (O(1)).
    Acc1 = backtrack(Target, NewSum, NewCombinationReversed, RestCandidates, Acc),

    % Option 2: Skip the current Candidate (and any subsequent duplicates of it at this level).
    % Find the next unique candidate in RestCandidates.
    NextUniqueCandidates = skip_duplicates(RestCandidates, Candidate),
    Acc2 = backtrack(Target, CurrentSum, CurrentCombinationReversed, NextUniqueCandidates, Acc1),
    Acc2;

backtrack(_Target, _CurrentSum, _CurrentCombinationReversed, [], Acc) ->
    Acc.

skip_duplicates([Value | Rest], Value) ->
    skip_duplicates(Rest, Value);
skip_duplicates(List, _Value) ->
    List.