-module(solution).
-export([max_score/2]).

max_score(Nums, Multipliers) ->
    N = length(Nums),
    M = length(Multipliers),
    NumsT = list_to_tuple(Nums),
    MultipliersT = list_to_tuple(Multipliers),

    Memo = #{},

    {Score, _FinalMemo} = solve(0, 0, NumsT, MultipliersT, N, M, Memo),
    Score.

solve(OpIdx, LeftTaken, NumsT, MultipliersT, N, M, Memo) ->
    if OpIdx == M ->
        {0, Memo};
    true ->
        Key = {OpIdx, LeftTaken},
        case maps:find(Key, Memo) of
            {ok, Score} ->
                {Score, Memo};
            _ ->
                Multiplier = element(OpIdx + 1, MultipliersT),

                LeftNum = element(LeftTaken + 1, NumsT),
                {ScoreLeftSubproblem, Memo1} = solve(OpIdx + 1, LeftTaken + 1, NumsT, MultipliersT, N, M, Memo),
                ScoreLeft = Multiplier * LeftNum + ScoreLeftSubproblem,

                RightTaken = OpIdx - LeftTaken,
                RightNumIdx = N - RightTaken,
                RightNum = element(RightNumIdx, NumsT),
                {ScoreRightSubproblem, Memo2} = solve(OpIdx + 1, LeftTaken, NumsT, MultipliersT, N, M, Memo1),
                ScoreRight = Multiplier * RightNum + ScoreRightSubproblem,

                MaxScore = max(ScoreLeft, ScoreRight),

                NewMemo = maps:put(Key, MaxScore, Memo2),
                {MaxScore, NewMemo}
        end
    end.