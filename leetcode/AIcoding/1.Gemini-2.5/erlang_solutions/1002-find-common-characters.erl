-module(solution).
-export([commonChars/1]).

commonChars([]) -> [];
commonChars([Word | RestWords]) ->
    InitialFreqMap = word_to_freq_map(Word),
    FinalFreqMap = lists:foldl(
        fun(CurrentWord, AccFreqMap) ->
            CurrentWordFreqMap = word_to_freq_map(CurrentWord),
            intersect_freq_maps(AccFreqMap, CurrentWordFreqMap)
        end,
        InitialFreqMap,
        RestWords
    ),
    freq_map_to_chars(FinalFreqMap).

word_to_freq_map(Word) ->
    lists:foldl(
        fun(Char, FreqMap) ->
            Idx = Char - $a,
            lists:replace_nth(Idx + 1, lists:nth(Idx + 1, FreqMap) + 1, FreqMap)
        end,
        lists:duplicate(26, 0),
        Word
    ).

intersect_freq_maps(Map1, Map2) ->
    lists:zipwith(fun(Count1, Count2) -> min(Count1, Count2) end, Map1, Map2).

freq_map_to_chars(FreqMap) ->
    lists:flatten(
        lists:map(fun(Idx) ->
                          Char = Idx + $a,
                          Count = lists:nth(Idx + 1, FreqMap),
                          lists:duplicate(Count, Char)
                  end, lists:seq(0, 25))
    ).