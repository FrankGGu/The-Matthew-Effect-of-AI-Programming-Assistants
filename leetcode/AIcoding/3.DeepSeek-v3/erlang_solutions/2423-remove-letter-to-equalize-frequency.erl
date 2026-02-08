-spec equal_frequency(Word :: unicode:unicode_binary()) -> boolean().
equal_frequency(Word) ->
    FreqMap = lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, unicode:characters_to_list(Word)),
    Freqs = maps:values(FreqMap),
    lists:any(fun(F) -> check_freqs(Freqs, F) end, Freqs).

check_freqs(Freqs, F) ->
    NewFreqs = lists:map(fun(X) -> if X == F -> X - 1; true -> X end end, Freqs),
    Filtered = lists:filter(fun(X) -> X > 0 end, NewFreqs),
    case Filtered of
        [] -> true;
        [H|T] -> lists:all(fun(X) -> X == H end, T)
    end.