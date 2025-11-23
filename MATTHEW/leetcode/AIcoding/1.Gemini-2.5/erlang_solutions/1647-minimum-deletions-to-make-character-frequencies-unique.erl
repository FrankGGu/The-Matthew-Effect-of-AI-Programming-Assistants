-module(solution).
-export([min_deletions/1]).

min_deletions(S) ->
    FreqMap = lists:foldl(
        fun(Char, AccMap) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, 1, AccMap)
        end,
        maps:new(),
        S
    ),
    Frequencies = maps:values(FreqMap),
    SortedFrequencies = lists:sort(fun(A, B) -> A >= B end, Frequencies),
    process_frequencies(SortedFrequencies, sets:new(), 0).

process_frequencies([], _UsedFreqs, Deletions) ->
    Deletions;
process_frequencies([CurrentFreq | Rest], UsedFreqs, Deletions) ->
    case sets:is_element(CurrentFreq, UsedFreqs) of
        true ->
            NewFreq = CurrentFreq - 1,
            NewDeletions = Deletions + 1,
            process_frequencies([NewFreq | Rest], UsedFreqs, NewDeletions);
        false ->
            case CurrentFreq > 0 of
                true ->
                    NewUsedFreqs = sets:add_element(CurrentFreq, UsedFreqs),
                    process_frequencies(Rest, NewUsedFreqs, Deletions);
                false ->
                    process_frequencies(Rest, UsedFreqs, Deletions)
            end
    end.