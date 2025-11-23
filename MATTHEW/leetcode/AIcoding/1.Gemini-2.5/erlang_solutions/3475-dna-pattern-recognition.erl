-module(solution).
-export([repeated_dna_sequences/2]).

repeated_dna_sequences(S, L) ->
    StrLen = length(S),
    FreqMap = count_sequences(S, L, 0, #{}, StrLen),
    extract_repeated(FreqMap).

count_sequences(_S, _L, Index, FreqMap, StrLen) when Index + _L > StrLen ->
    FreqMap;
count_sequences(S, L, Index, FreqMap, StrLen) ->
    Sub = lists:sublist(S, Index + 1, L),
    NewFreqMap = maps:update_with(Sub, fun(Count) -> Count + 1 end, 1, FreqMap),
    count_sequences(S, L, Index + 1, NewFreqMap, StrLen).

extract_repeated(FreqMap) ->
    lists:foldl(
        fun({Key, Val}, Acc) ->
            if Val > 1 -> [Key | Acc];
               true -> Acc
            end
        end,
        [],
        maps:to_list(FreqMap)
    ).