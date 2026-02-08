-module(count_prefix_suffix_pairs_i).
-export([countPrefixSuffixPairs/1]).

countPrefixSuffixPairs(Words) ->
    countPrefixSuffixPairs(Words, 0).

countPrefixSuffixPairs([], Count) ->
    Count;
countPrefixSuffixPairs([Word | Rest], Count) ->
    NewCount = countPairs(Word, Rest, Count),
    countPrefixSuffixPairs(Rest, NewCount).

countPairs(_, [], Count) ->
    Count;
countPairs(Word, [OtherWord | Rest], Count) ->
    case isPrefixAndSuffix(Word, OtherWord) of
        true ->
            countPairs(Word, Rest, Count + 1);
        false ->
            countPairs(Word, Rest, Count)
    end.

isPrefixAndSuffix(Word, OtherWord) ->
    WordLen = length(Word),
    OtherWordLen = length(OtherWord),
    WordLen =< OtherWordLen andalso
    Word == lists:sublist(OtherWord, WordLen) andalso
    Word == lists:sublist(OtherWord, OtherWordLen - WordLen + 1, WordLen).