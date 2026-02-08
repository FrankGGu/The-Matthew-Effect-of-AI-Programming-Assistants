-spec max_product(Words :: [unicode:unicode_binary()]) -> integer().
max_product(Words) ->
    Masks = lists:map(fun(Word) ->
        lists:foldl(fun(Char, Acc) ->
            Acc bor (1 bsl (Char - $a))
        end, 0, binary_to_list(Word))
    end, Words),
    Max = 0,
    find_max(Masks, Words, Max).

find_max([], _, Max) -> Max;
find_max([Mask | Masks], Words, Max) ->
    {NewMax, _} = lists:foldl(fun({OtherMask, OtherWord}, {CurrentMax, Index}) ->
        case (Mask band OtherMask) =:= 0 of
            true ->
                Product = byte_size(lists:nth(Index, Words)) * byte_size(OtherWord),
                {max(CurrentMax, Product), Index + 1};
            false ->
                {CurrentMax, Index + 1}
        end
    end, {Max, 1}, lists:zip(Masks, tl(Words))),
    find_max(Masks, Words, NewMax).