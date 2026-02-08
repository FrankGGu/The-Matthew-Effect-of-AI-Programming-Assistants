-spec largest_merge(Word1 :: unicode:unicode_binary(), Word2 :: unicode:unicode_binary()) -> unicode:unicode_binary().
largest_merge(Word1, Word2) ->
    largest_merge(Word1, Word2, <<>>).

largest_merge(<<>>, Word2, Acc) ->
    <<Acc/binary, Word2/binary>>;
largest_merge(Word1, <<>>, Acc) ->
    <<Acc/binary, Word1/binary>>;
largest_merge(<<C1, Rest1/binary>> = Word1, <<C2, Rest2/binary>> = Word2, Acc) ->
    case Word1 > Word2 of
        true ->
            largest_merge(Rest1, Word2, <<Acc/binary, C1>>);
        false ->
            largest_merge(Word1, Rest2, <<Acc/binary, C2>>)
    end.