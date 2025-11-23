-spec minimum_operations_to_make_strings_equal(S1 :: unicode:unicode_binary(), S2 :: unicode:unicode_binary(), S3 :: unicode:unicode_binary()) -> integer().
minimum_operations_to_make_strings_equal(S1, S2, S3) ->
    L1 = unicode:characters_to_list(S1),
    L2 = unicode:characters_to_list(S2),
    L3 = unicode:characters_to_list(S3),
    Len = max(max(length(L1), length(L2)), length(L3)),
    Padded1 = pad_list(L1, Len),
    Padded2 = pad_list(L2, Len),
    Padded3 = pad_list(L3, Len),
    count_operations(Padded1, Padded2, Padded3, 0).

pad_list(List, Len) ->
    List ++ lists:duplicate(Len - length(List), $0).

count_operations([], [], [], Acc) -> Acc;
count_operations([H1|T1], [H2|T2], [H3|T3], Acc) ->
    Chars = [H1, H2, H3],
    case lists:usort(Chars) of
        [C] -> count_operations(T1, T2, T3, Acc);
        [_, C, C] -> count_operations(T1, T2, T3, Acc + 1);
        [_, _, _] -> count_operations(T1, T2, T3, Acc + 2)
    end.