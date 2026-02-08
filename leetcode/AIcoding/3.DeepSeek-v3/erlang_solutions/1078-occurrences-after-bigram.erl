-spec find_occurrences(Text :: unicode:unicode_binary(), First :: unicode:unicode_binary(), Second :: unicode:unicode_binary()) -> [unicode:unicode_binary()].
find_occurrences(Text, First, Second) ->
    Words = binary:split(Text, <<" ">>, [global]),
    find_occurrences(Words, First, Second, []).

find_occurrences([_, _], _, _, Acc) ->
    lists:reverse(Acc);
find_occurrences([A, B, C | Rest], First, Second, Acc) ->
    case A =:= First andalso B =:= Second of
        true -> find_occurrences([B, C | Rest], First, Second, [C | Acc]);
        false -> find_occurrences([B, C | Rest], First, Second, Acc)
    end;
find_occurrences(_, _, _, Acc) ->
    lists:reverse(Acc).