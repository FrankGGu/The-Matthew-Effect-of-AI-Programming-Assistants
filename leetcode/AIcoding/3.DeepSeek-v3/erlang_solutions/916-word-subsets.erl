-spec word_subsets(A :: [unicode:unicode_binary()], B :: [unicode:unicode_binary()]) -> [unicode:unicode_binary()].
word_subsets(A, B) ->
    BCount = lists:foldl(fun(BWord, Acc) ->
        Count = count_chars(BWord),
        merge_counts(Acc, Count)
    end, #{}, B),
    lists:filter(fun(AWord) ->
        ACount = count_chars(AWord),
        is_subset(BCount, ACount)
    end, A).

count_chars(Word) ->
    lists:foldl(fun(Char, Acc) ->
        maps:update_with(Char, fun(V) -> V + 1 end, 1, Acc)
    end, #{}, unicode:characters_to_list(Word)).

merge_counts(Count1, Count2) ->
    maps:fold(fun(Char, C2, Acc) ->
        C1 = maps:get(Char, Acc, 0),
        maps:put(Char, max(C1, C2), Acc)
    end, Count1, Count2).

is_subset(BCount, ACount) ->
    maps:fold(fun(Char, B, true) ->
        A = maps:get(Char, ACount, 0),
        A >= B
    ; (_, _, false) -> false end, true, BCount).