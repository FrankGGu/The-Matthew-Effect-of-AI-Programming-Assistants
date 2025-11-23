-module(solution).
-export([findRelativeRanks/1]).

findRelativeRanks(Scores) ->
    IndexedScores = lists:zip(lists:seq(0, length(Scores) - 1), Scores),
    SortedIndexedScores = lists:sort(fun({_IdxA, ScoreA}, {_IdxB, ScoreB}) -> ScoreA >= ScoreB end, IndexedScores),

    {_FinalRank, RankedListReverse} = lists:foldl(
        fun({OriginalIdx, _Score}, {CurrentRank, Acc}) ->
            RankString = case CurrentRank of
                1 -> "Gold Medal";
                2 -> "Silver Medal";
                3 -> "Bronze Medal";
                _ -> integer_to_list(CurrentRank)
            end,
            {CurrentRank + 1, [{OriginalIdx, RankString} | Acc]}
        end,
        {1, []},
        SortedIndexedScores
    ),

    SortedByOriginalIdx = lists:sort(fun({IdxA, _RankA}, {IdxB, _RankB}) -> IdxA =< IdxB end, RankedListReverse),

    [Rank || {_Idx, Rank} <- SortedByOriginalIdx].