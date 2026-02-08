-spec num_special_equiv_groups(Words :: [unicode:unicode_binary()]) -> integer().
num_special_equiv_groups(Words) ->
    Groups = lists:foldl(fun(Word, Acc) ->
        {Even, Odd} = split_word(Word, 0, [], []),
        SortedEven = lists:sort(Even),
        SortedOdd = lists:sort(Odd),
        Key = {SortedEven, SortedOdd},
        sets:add_element(Key, Acc)
    end, sets:new(), Words),
    sets:size(Groups).

split_word(<<>>, _Index, Even, Odd) ->
    {Even, Odd};
split_word(<<C, Rest/binary>>, Index, Even, Odd) ->
    case Index rem 2 of
        0 -> split_word(Rest, Index + 1, [C | Even], Odd);
        1 -> split_word(Rest, Index + 1, Even, [C | Odd])
    end.