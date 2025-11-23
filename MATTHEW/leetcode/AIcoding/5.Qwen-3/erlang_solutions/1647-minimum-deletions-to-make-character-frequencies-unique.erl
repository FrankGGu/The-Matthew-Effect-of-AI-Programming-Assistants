-module(minimum_deletions_to_make_character_frequencies_unique).
-export([minDeletions/1]).

minDeletions(S) ->
    Freq = lists:foldl(fun(Char, Acc) -> 
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc) 
    end, #{}, S),
    SortedFreqs = lists:reverse(lists:sort(maps:values(Freq))),
    process(SortedFreqs, 0).

process([], _) ->
    0;
process([F | Rest], MaxFreq) when F < MaxFreq ->
    Deletions = MaxFreq - F,
    Deletions + process(Rest, MaxFreq - 1);
process([F | Rest], MaxFreq) ->
    process(Rest, F).