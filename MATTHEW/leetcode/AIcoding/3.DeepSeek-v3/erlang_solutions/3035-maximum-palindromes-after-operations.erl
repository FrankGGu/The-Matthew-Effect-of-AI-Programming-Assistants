-spec max_palindromes_after_operations(Words :: [unicode:unicode_binary()]) -> integer().
max_palindromes_after_operations(Words) ->
    CharCounts = lists:foldl(fun(Word, Acc) ->
        lists:foldl(fun(Char, Counts) ->
            maps:update_with(Char, fun(V) -> V + 1 end, 1, Counts)
        end, Acc, unicode:characters_to_list(Word))
    end, maps:new(), Words),
    Freqs = lists:sort(fun(A, B) -> A >= B end, maps:values(CharCounts)),
    {Pairs, Odd} = lists:foldl(fun(Freq, {P, O}) ->
        Pairs = P + Freq div 2,
        Odd1 = case Freq rem 2 of
            1 -> O + 1;
            0 -> O
        end,
        {Pairs, Odd1}
    end, {0, 0}, Freqs),
    min(length(Words), Pairs * 2 + min(1, Odd)).