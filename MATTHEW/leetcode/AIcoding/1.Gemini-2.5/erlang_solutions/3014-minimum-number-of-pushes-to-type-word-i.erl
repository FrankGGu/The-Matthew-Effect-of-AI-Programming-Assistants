-spec minimum_pushes(Word :: unicode:unicode_binary()) -> integer().
minimum_pushes(Word) ->
    CharList = unicode:characters_to_list(Word),
    FreqMap = lists:foldl(
        fun(Char, Acc) ->
            maps:update_with(Char, fun(Count) -> Count + 1 end, 1, Acc)
        end,
        #{},
        CharList
    ),
    Frequencies = maps:values(FreqMap),
    SortedFrequencies = lists:sort(fun(A, B) -> A >= B end, Frequencies),
    calculate_pushes(SortedFrequencies, 0, 0).

calculate_pushes([], _Index, TotalPushes) ->
    TotalPushes;
calculate_pushes([Freq | Rest], Index, AccPushes) ->
    Cost = (Index div 8) + 1,
    NewAccPushes = AccPushes + (Freq * Cost),
    calculate_pushes(Rest, Index + 1, NewAccPushes).