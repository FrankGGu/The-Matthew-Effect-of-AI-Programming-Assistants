-module(solution).
-export([combination_sum/2]).

combination_sum(Candidates, Target) ->
    SortedCandidates = lists:sort(Candidates),
    backtrack(Target, [], SortedCandidates).

backtrack(RemainingTarget, CurrentCombination, CandidatesTail) ->
    if
        RemainingTarget == 0 ->
            [CurrentCombination];
        RemainingTarget < 0 ->
            [];
        true ->
            generate_combinations_from_tail(RemainingTarget, CurrentCombination, CandidatesTail, [])
    end.

generate_combinations_from_tail(_RemainingTarget, _CurrentCombination, [], Acc) ->
    Acc;
generate_combinations_from_tail(RemainingTarget, CurrentCombination, [C | RestCandidates], Acc) ->
    NewAcc = if C =< RemainingTarget ->
                 SubCombinations = backtrack(RemainingTarget - C, CurrentCombination ++ [C], [C | RestCandidates]),
                 SubCombinations ++ Acc;
             else ->
                 Acc
             end,
    generate_combinations_from_tail(RemainingTarget, CurrentCombination, RestCandidates, NewAcc).