-spec faulty_keyboard(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
faulty_keyboard(S) ->
    lists:foldl(fun
        ($i, Acc) -> lists:reverse(Acc);
        (Char, Acc) -> [Char | Acc]
    end, [], binary_to_list(S)).