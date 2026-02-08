-module(solution).
-export([minimumOperations/2]).

minimumOperations(Word, K) ->
    N = length(Word),
    NumBlocks = N div K,
    Substrings = split_word(Word, K, N, []),
    Frequencies = count_frequencies(Substrings, #{}),
    MaxFreq = find_max_frequency(Frequencies),
    NumBlocks - MaxFreq.

split_word(Word, K, N, Acc) ->
    case N > 0 of
        true ->
            Block = lists:sublist(Word, 1, K),
            RemainingWord = lists:nthtail(K, Word),
            split_word(RemainingWord, K, N - K, [Block | Acc]);
        false ->
            lists:reverse(Acc)
    end.

count_frequencies([], FreqMap) ->
    FreqMap;
count_frequencies([Sub | Rest], FreqMap) ->
    NewFreqMap = maps:update_with(Sub, fun(Val) -> Val + 1 end, 1, FreqMap),
    count_frequencies(Rest, NewFreqMap).

find_max_frequency(FreqMap) ->
    case maps:size(FreqMap) of
        0 -> 0;
        _ -> lists:max(maps:values(FreqMap))
    end.