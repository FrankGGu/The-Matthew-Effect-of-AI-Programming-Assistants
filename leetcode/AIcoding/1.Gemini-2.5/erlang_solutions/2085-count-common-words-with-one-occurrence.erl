-module(solution).
-export([count_common_words_with_one_occurrence/2]).

count_common_words_with_one_occurrence(Words1, Words2) ->
    FreqMap1 = count_frequencies(Words1),
    FreqMap2 = count_frequencies(Words2),

    SingleOccWordsSet1 = get_single_occurrence_words_set(FreqMap1),
    SingleOccWordsSet2 = get_single_occurrence_words_set(FreqMap2),

    CommonSingleOccWords = sets:intersection(SingleOccWordsSet1, SingleOccWordsSet2),
    sets:size(CommonSingleOccWords).

count_frequencies(Words) ->
    lists:foldl(fun(Word, AccMap) ->
                        maps:update_with(Word, fun(Count) -> Count + 1 end, 1, AccMap)
                end, maps:new(), Words).

get_single_occurrence_words_set(FreqMap) ->
    sets:from_list(maps:fold(fun(Word, Count, AccList) ->
                                     if Count == 1 -> [Word | AccList];
                                        true -> AccList
                                     end
                             end, [], FreqMap)).