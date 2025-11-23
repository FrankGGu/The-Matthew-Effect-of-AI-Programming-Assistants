-module(solution).
-export([minOperations/1]).

minOperations(S) ->
    FreqMap = count_frequencies(S),
    FreqList = maps:values(FreqMap),
    SortedFreqList = lists:sort(fun(A, B) -> A >= B end, FreqList),
    process_frequencies(SortedFreqList, gb_sets:new(), 0).

count_frequencies(S) ->
    lists:foldl(fun(Char, Acc) ->
                        maps:update_with(Char, fun(Val) -> Val + 1 end, 1, Acc)
                end, #{}, S).

process_frequencies([], _UsedFreqs, Operations) ->
    Operations;
process_frequencies([CurrentFreq | Rest], UsedFreqs, Operations) ->
    {NewFreq, NewOps} = decrement_until_unique(CurrentFreq, UsedFreqs, 0),
    NewUsedFreqs = if NewFreq > 0 -> gb_sets:add(NewFreq, UsedFreqs);
                       true -> UsedFreqs
                   end,
    process_frequencies(Rest, NewUsedFreqs, Operations + NewOps).

decrement_until_unique(0, _UsedFreqs, CurrentOps) ->
    {0, CurrentOps};
decrement_until_unique(Freq, UsedFreqs, CurrentOps) ->
    if gb_sets:is_member(Freq, UsedFreqs) ->
           decrement_until_unique(Freq - 1, UsedFreqs, CurrentOps + 1);
       true ->
           {Freq, CurrentOps}
    end.