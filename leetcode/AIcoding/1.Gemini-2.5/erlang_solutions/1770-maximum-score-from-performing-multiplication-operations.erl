-module(solution).
-export([max_score/2]).

max_score(Nums, Multipliers) ->
    N = length(Nums),
    M = length(Multipliers),
    NumsArr = array:from_list(Nums),
    MultipliersArr = array:from_list(Multipliers),
    Memo = #{},
    {Score, _FinalMemo} = solve(0, 0, NumsArr, MultipliersArr, N, M, Memo),
    Score.

solve(K, LeftCount, NumsArr, MultipliersArr, N, M, Memo) ->
    if K == M ->
        {0, Memo};
    true ->
        case maps:find({K, LeftCount}, Memo) of
            {ok, CachedScore} ->
                {CachedScore, Memo};
            error ->
                RightCount = K - LeftCount,
                Multiplier = array:get(K, MultipliersArr),

                LeftVal = array:get(LeftCount, NumsArr),
                {ScoreFromLeft, Memo1} = solve(K + 1, LeftCount + 1, NumsArr, MultipliersArr, N, M, Memo),
                TotalScoreFromLeft = Multiplier * LeftVal + ScoreFromLeft,

                RightValIdx = N - 1 - RightCount,
                RightVal = array:get(RightValIdx, NumsArr),
                {ScoreFromRight, Memo2} = solve(K + 1, LeftCount, NumsArr, MultipliersArr, N, M, Memo1),
                TotalScoreFromRight = Multiplier * RightVal + ScoreFromRight,

                MaxScore = max(TotalScoreFromLeft, TotalScoreFromRight),
                NewMemo = maps:put({K, LeftCount}, MaxScore, Memo2),
                {MaxScore, NewMemo}
        end
    end.