-spec max_product(Words :: [unicode:unicode_binary()]) -> integer().
max_product(Words) ->
    Masks = lists:map(fun(Word) ->
        lists:foldl(fun(Char, Acc) ->
            Acc bor (1 bsl (Char - $a))
        end, 0, unicode:characters_to_list(Word))
    end, Words),
    Max = 0,
    find_max_product(Masks, Words, 0, Max).

find_max_product([], _, _, Max) -> Max;
find_max_product([Mask | RestMasks], Words, Index, Max) ->
    Word = lists:nth(Index + 1, Words),
    NewMax = check_rest(Mask, RestMasks, Words, Index + 1, length(Word), Max),
    find_max_product(RestMasks, Words, Index + 1, NewMax).

check_rest(_, [], _, _, _, Max) -> Max;
check_rest(Mask1, [Mask2 | RestMasks], Words, OtherIndex, Len1, Max) ->
    case (Mask1 band Mask2) == 0 of
        true ->
            Len2 = length(lists:nth(OtherIndex + 1, Words)),
            Product = Len1 * Len2,
            NewMax = max(Product, Max),
            check_rest(Mask1, RestMasks, Words, OtherIndex + 1, Len1, NewMax);
        false ->
            check_rest(Mask1, RestMasks, Words, OtherIndex + 1, Len1, Max)
    end.