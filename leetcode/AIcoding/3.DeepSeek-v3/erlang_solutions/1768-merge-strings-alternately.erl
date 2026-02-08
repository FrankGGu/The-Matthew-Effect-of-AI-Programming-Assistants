-spec merge_alternately(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
merge_alternately(Word1, Word2) ->
    merge_alternately(binary_to_list(Word1), binary_to_list(Word2), []).

merge_alternately([], [], Acc) ->
    list_to_binary(lists:reverse(Acc));
merge_alternately([], [H2 | T2], Acc) ->
    merge_alternately([], T2, [H2 | Acc]);
merge_alternately([H1 | T1], [], Acc) ->
    merge_alternately(T1, [], [H1 | Acc]);
merge_alternately([H1 | T1], [H2 | T2], Acc) ->
    merge_alternately(T1, T2, [H2, H1 | Acc]).