-module(solution).
-export([uncommonFromSentences/2]).

uncommonFromSentences(S1, S2) ->
    Words1 = string:tokens(S1, " "),
    Words2 = string:tokens(S2, " "),

    AllWords = Words1 ++ Words2,

    WordCounts = lists:foldl(
        fun(Word, AccMap) ->
            maps:update_with(Word, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        AllWords
    ),

    maps:fold(
        fun(Word, Count, AccList) ->
            if Count == 1 -> [Word | AccList];
               true -> AccList
            end
        end,
        [],
        WordCounts
    ).