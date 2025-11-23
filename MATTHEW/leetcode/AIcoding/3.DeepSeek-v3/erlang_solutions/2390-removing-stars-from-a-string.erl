-spec remove_stars(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
remove_stars(S) ->
    remove_stars(S, []).

remove_stars(<<>>, Acc) ->
    unicode:characters_to_binary(lists:reverse(Acc));
remove_stars(<<$*, Rest/binary>>, [_ | T]) ->
    remove_stars(Rest, T);
remove_stars(<<C, Rest/binary>>, Acc) ->
    remove_stars(Rest, [C | Acc]).