-module(solution).
-export([arrayRankTransform/1]).

arrayRankTransform(Arr) ->
    UniqueSorted = lists:usort(Arr),
    RankedPairs = lists:zip(UniqueSorted, lists:seq(1, length(UniqueSorted))),
    RankMap = maps:from_list(RankedPairs),
    [maps:get(X, RankMap) || X <- Arr].