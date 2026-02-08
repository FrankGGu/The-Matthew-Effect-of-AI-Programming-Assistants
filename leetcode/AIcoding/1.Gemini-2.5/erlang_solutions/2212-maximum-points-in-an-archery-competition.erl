-module(solution).
-export([maximumPoints/2]).

maximumPoints(NumArrows, AliceArrows) ->
    MemoTable = ets:new(archery_memo, [set, protected, {read_concurrency, true}]),
    {_FinalScore, BobArrowsReversed} = solve(11, NumArrows, AliceArrows, MemoTable),
    ets:delete(MemoTable),
    lists:reverse(BobArrowsReversed).

solve(0, RemainingArrows, _AliceArrows, _MemoTable) ->
    {0, [RemainingArrows]};

solve(CategoryIndex, RemainingArrows, AliceArrows, MemoTable) ->
    case ets:lookup(MemoTable, {CategoryIndex, RemainingArrows}) of
        [{_, Result}] ->
            Result;
        [] ->
            {ScoreLose, ArrowsLoseTail} = solve(CategoryIndex - 1, RemainingArrows, AliceArrows, MemoTable),
            BobArrowsLose = [0 | ArrowsLoseTail],

            AliceArrowsForCurrentCategory = lists:nth(CategoryIndex + 1, AliceArrows),
            ArrowsNeededToWin = AliceArrowsForCurrentCategory + 1,

            Result = 
                if RemainingArrows >= ArrowsNeededToWin ->
                    {ScoreWinTail, ArrowsWinTail} = solve(CategoryIndex - 1, RemainingArrows - ArrowsNeededToWin, AliceArrows, MemoTable),
                    ScoreWin = CategoryIndex + ScoreWinTail,
                    BobArrowsWin = [ArrowsNeededToWin | ArrowsWinTail],

                    if ScoreWin >= ScoreLose ->
                        {ScoreWin, BobArrowsWin};
                    true ->
                        {ScoreLose, BobArrowsLose}
                    end;
                true ->
                    {ScoreLose, BobArrowsLose}
                end,

            ets:insert(MemoTable, {{CategoryIndex, RemainingArrows}, Result}),
            Result
    end.