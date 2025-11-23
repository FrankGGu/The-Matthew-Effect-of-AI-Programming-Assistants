-spec smallest_string(S :: unicode:unicode_binary()) -> unicode:unicode_binary().
smallest_string(S) ->
    Bin = unicode:characters_to_binary(S),
    smallest_string(Bin, 0, size(Bin)).

smallest_string(Bin, I, Size) when I < Size ->
    case binary:at(Bin, I) of
        $a when I =:= Size - 1 ->
            <<Prefix:Size/binary, _>> = Bin,
            <<Prefix/binary, $z>>;
        $a ->
            smallest_string(Bin, I + 1, Size);
        Char ->
            <<Prefix:I/binary, _/binary>> = Bin,
            <<Suffix/binary>> = binary:part(Bin, I + 1, Size - I - 1),
            NewChar = Char - 1,
            <<Prefix/binary, NewChar, Suffix/binary>>
    end;
smallest_string(Bin, _, _) ->
    Bin.