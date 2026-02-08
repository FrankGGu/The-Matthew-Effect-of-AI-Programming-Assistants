-spec reverse_prefix(Word :: unicode:unicode_binary(), Ch :: char()) -> unicode:unicode_binary().
reverse_prefix(Word, Ch) ->
    case binary:match(Word, <<Ch>>) of
        nomatch ->
            Word;
        {Pos, _} ->
            Prefix = binary:part(Word, 0, Pos + 1),
            Reversed = binary:reverse(Prefix),
            <<Reversed/binary, (binary:part(Word, Pos + 1, byte_size(Word) - Pos - 1))/binary>>
    end.