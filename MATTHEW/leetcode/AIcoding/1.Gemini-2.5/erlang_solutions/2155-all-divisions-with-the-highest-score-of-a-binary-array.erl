-module(solution).
-export([max_score_indices/1]).

-spec max_score_indices(Nums :: [integer()]) -> [integer()].
max_score_indices(Nums) ->
    TotalOnes = lists:sum(Nums),

    % InitialState: {CurrentDivisionPoint, ZerosLeft, OnesRight, MaxScore, ResultIndicesReversed}
    % ResultIndicesReversed stores indices in reverse order to allow O(1) prepend.
    InitialState = {0, 0, TotalOnes, TotalOnes, [0]},

    {_FinalDivisionPoint, _FinalZerosLeft, _FinalOnesRight, _MaxScoreSoFar, ResultIndicesReversed} =
        lists:foldl(fun(Num, {CurrentDivIdx, ZL, OR, MS, RIsRev}) ->
                        % Update ZL and OR for the *next* division point (CurrentDivIdx + 1)
                        NewZL = ZL + (1 - Num), % If Num is 0, ZL increases by 1. If Num is 1, ZL stays same.
                        NewOR = OR - Num,       % If Num is 1, OR decreases by 1. If Num is 0, OR stays same.

                        % Calculate score for the *next* division point (CurrentDivIdx + 1)
                        NextScore = NewZL + NewOR,

                        NextDivIdx = CurrentDivIdx + 1,

                        case NextScore of
                            S when S > MS ->
                                {NextDivIdx, NewZL, NewOR, S, [NextDivIdx]}; % New max score, start new list
                            S when S == MS ->
                                {NextDivIdx, NewZL, NewOR, MS, [NextDivIdx | RIsRev]}; % Same max score, prepend
                            _ ->
                                {NextDivIdx, NewZL, NewOR, MS, RIsRev} % Lower score, keep current max and list
                        end
                end, InitialState, Nums),

    lists:reverse(ResultIndicesReversed).