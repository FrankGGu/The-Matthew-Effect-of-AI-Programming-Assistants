-spec remove_duplicates(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_duplicates(S) ->
    remove_duplicates(S, <<>>).

remove_duplicates(<<>>, Acc) ->
    Acc;
remove_duplicates(<<C, Rest/binary>>, <<>>) ->
    remove_duplicates(Rest, <<C>>);
remove_duplicates(<<C, Rest/binary>>, <<AccLast, AccRest/binary>>) ->
    if
        C =:= AccLast ->
            remove_duplicates(Rest, AccRest);
        true ->
            remove_duplicates(Rest, <<AccLast, AccRest/binary, C>>)
    end.