-spec min_deletions(S :: unicode:unicode_binary()) -> integer().
min_deletions(S) ->
    FreqMap = lists:foldl(fun(Char, Acc) ->
                                  maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
                          end, #{}, unicode:characters_to_list(S)),
    Freqs = lists:sort(fun(A, B) -> A > B end, maps:values(FreqMap)),
    min_deletions(Freqs, 0, sets:new()).

min_deletions([], Deletions, _) -> Deletions;
min_deletions([Freq | Rest], Deletions, Used) ->
    case sets:is_element(Freq, Used) of
        true ->
            NewFreq = max(0, Freq - 1),
            min_deletions([NewFreq | Rest], Deletions + 1, Used);
        false ->
            min_deletions(Rest, Deletions, sets:add_element(Freq, Used))
    end.