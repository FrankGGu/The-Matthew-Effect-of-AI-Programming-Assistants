-spec min_operations(Nums :: [integer()]) -> integer().
min_operations(Nums) ->
    FrequencyMap = frequency_map(Nums),
    SortedFreqs = lists:sort(maps:values(FrequencyMap)),
    min_operations(SortedFreqs, 0, #{}).

frequency_map(Nums) ->
    lists:foldl(fun(N, Acc) -> maps:update_with(N, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums).

min_operations([], Operations, _) -> Operations;
min_operations([Freq | Rest], Operations, Used) ->
    case maps:is_key(Freq, Used) of
        false ->
            min_operations(Rest, Operations, Used#{Freq => true});
        true ->
            NewFreq = find_next_available(Freq, Used),
            min_operations(Rest, Operations + (NewFreq - Freq), Used#{NewFreq => true})
    end.

find_next_available(Freq, Used) ->
    find_next_available(Freq + 1, Freq + 1, Used).

find_next_available(Start, Current, Used) ->
    case maps:is_key(Current, Used) of
        false -> Current;
        true -> find_next_available(Start, Current + 1, Used)
    end.