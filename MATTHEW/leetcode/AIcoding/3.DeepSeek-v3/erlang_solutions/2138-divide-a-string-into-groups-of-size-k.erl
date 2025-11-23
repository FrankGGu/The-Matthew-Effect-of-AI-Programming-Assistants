-spec divide_string(S :: unicode:unicode_binary(), K :: integer(), Fill :: char()) -> [unicode:unicode_binary()].
divide_string(S, K, Fill) ->
    Len = byte_size(S),
    Rem = case Len rem K of
        0 -> 0;
        R -> K - R
    end,
    Padded = <<S/binary, (binary:copy(<<Fill>>, Rem))/binary>>,
    divide(Padded, K, []).

divide(<<>>, _, Acc) ->
    lists:reverse(Acc);
divide(Bin, K, Acc) ->
    <<Part:K/binary, Rest/binary>> = Bin,
    divide(Rest, K, [Part | Acc]).