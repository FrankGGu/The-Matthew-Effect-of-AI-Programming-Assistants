-spec max_product(Words :: [unicode:unicode_binary()]) -> integer().
max_product(Words) ->
    WordMasks = [word_to_mask(W) || W <- Words],
    max_product_helper(WordMasks, length(WordMasks), 0).

max_product_helper([], _, Max) -> Max;
max_product_helper([Mask1 | Rest], Len, Max) ->
    Max1 = lists:max([Max, max_product_for_word(Mask1, Rest, Len)]),
    max_product_helper(Rest, Len - 1, Max1).

max_product_for_word(_, [], _) -> 0;
max_product_for_word(Mask1, [Mask2 | Rest], Len) ->
    if 
        Mask1 band Mask2 == 0 -> 
            Len1 = length(Rest) + 1,
            Len1 * Len;
        true -> 
            max_product_for_word(Mask1, Rest, Len)
    end.

word_to_mask(Word) -> 
    lists:foldl(fun(C, Acc) -> Acc bor (1 bsl (C - $a)) end, 0, list:map(fun(C) -> C end, Word)).
