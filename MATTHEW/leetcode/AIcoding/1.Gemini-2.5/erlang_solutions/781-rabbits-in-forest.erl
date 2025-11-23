-module(rabbits_in_forest).
-export([rabbitsInForest/1]).

rabbitsInForest(Answers) ->
    FreqMap = lists:foldl(
        fun(Answer, AccMap) ->
            maps:update_with(Answer, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        Answers
    ),

    maps:fold(
        fun(Answer, Count, AccTotal) ->
            GroupSize = Answer + 1,
            NumGroups = (Count + GroupSize - 1) div GroupSize,
            AccTotal + (NumGroups * GroupSize)
        end,
        0,
        FreqMap
    ).