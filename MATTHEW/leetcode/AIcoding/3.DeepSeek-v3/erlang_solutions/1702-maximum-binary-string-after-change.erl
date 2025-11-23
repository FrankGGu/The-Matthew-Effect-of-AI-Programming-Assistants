-spec maximum_binary_string(Binary :: unicode:unicode_binary()) -> unicode:unicode_binary().
maximum_binary_string(Binary) ->
    case binary:matches(Binary, <<"0">>) of
        [] -> Binary;
        Matches ->
            {Pos, _} = hd(Matches),
            Count = length(Matches),
            Prefix = binary:part(Binary, 0, Pos),
            Middle = binary:copy(<<"1">>, Count - 1),
            Suffix = <<"0">>,
            Rest = binary:part(Binary, Pos + Count, byte_size(Binary) - Pos - Count),
            <<Prefix/binary, Middle/binary, Suffix/binary, Rest/binary>>
    end.