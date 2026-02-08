-spec make_fancy_string(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
make_fancy_string(S) ->
    make_fancy_string(S, <<>>, 0, <<>>).

make_fancy_string(<<>>, Acc, _Count, _Prev) ->
    Acc;
make_fancy_string(<<C, Rest/binary>>, Acc, Count, Prev) ->
    case C =:= Prev of
        true when Count >= 2 ->
            make_fancy_string(Rest, Acc, Count, Prev);
        true ->
            make_fancy_string(Rest, <<Acc/binary, C>>, Count + 1, C);
        false ->
            make_fancy_string(Rest, <<Acc/binary, C>>, 1, C)
    end.