-spec maximum_value(N :: unicode:unicode_binary(), X :: integer()) -> integer().
maximum_value(N, X) ->
    S = unicode:characters_to_list(N),
    XChar = integer_to_list(X),
    insert(S, XChar, []).

insert([], XChar, Acc) ->
    list_to_integer(lists:reverse(Acc) ++ XChar);
insert([H | T], XChar, Acc) ->
    case H < hd(XChar) of
        true ->
            list_to_integer(lists:reverse(Acc) ++ XChar ++ [H | T]);
        false ->
            insert(T, XChar, [H | Acc])
    end.