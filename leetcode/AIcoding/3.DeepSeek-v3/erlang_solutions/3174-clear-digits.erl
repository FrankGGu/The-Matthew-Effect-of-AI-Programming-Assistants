-spec remove_digits(Str :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_digits(Str) ->
    remove_digits(Str, []).

remove_digits(<<>>, Acc) ->
    unicode:characters_to_binary(lists:reverse(Acc));
remove_digits(<<C/utf8, Rest/binary>>, Acc) when C >= $0, C =< $9 ->
    case Acc of
        [] -> remove_digits(Rest, Acc);
        [_ | T] -> remove_digits(Rest, T)
    end;
remove_digits(<<C/utf8, Rest/binary>>, Acc) ->
    remove_digits(Rest, [C | Acc]).