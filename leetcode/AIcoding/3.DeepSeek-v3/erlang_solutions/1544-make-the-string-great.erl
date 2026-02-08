-spec make_good(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
make_good(S) ->
    make_good_helper(S, []).

make_good_helper(<<>>, Acc) ->
    unicode:characters_to_binary(lists:reverse(Acc));
make_good_helper(<<C, Rest/binary>>, [H | T]) when abs(C - H) =:= 32 ->
    make_good_helper(Rest, T);
make_good_helper(<<C, Rest/binary>>, Acc) ->
    make_good_helper(Rest, [C | Acc]).