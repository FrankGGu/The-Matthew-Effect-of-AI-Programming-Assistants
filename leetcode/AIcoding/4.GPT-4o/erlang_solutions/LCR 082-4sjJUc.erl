-module(solution).
-export([combination_sum2/2]).

combination_sum2(Candidates, Target) ->
    CandidatesSorted = lists:sort(Candidates),
    combination_sum2_helper(CandidatesSorted, Target, [], 1).

combination_sum2_helper([], _, Acc, _) -> 
    [Acc];
combination_sum2_helper(_, 0, Acc, _) -> 
    [Acc];
combination_sum2_helper(Candidates, Target, Acc, Start) ->
    lists:flatmap(fun(Index) ->
        case lists:nth(Index, Candidates) of
            _ when Index > Start -> 
                NewTarget = Target - lists:nth(Index, Candidates),
                NewAcc = lists:append(Acc, [lists:nth(Index, Candidates)]),
                combination_sum2_helper(Candidates, NewTarget, NewAcc, Index + 1);
            _ -> 
                []
        end
    end, lists:seq(Start, length(Candidates))).