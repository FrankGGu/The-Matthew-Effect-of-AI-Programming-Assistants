-spec reverse_str(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
reverse_str(S, K) ->
    Bin = unicode:characters_to_binary(S),
    Size = byte_size(Bin),
    reverse_str(Bin, 0, Size, K).

reverse_str(Bin, Start, Size, K) when Start >= Size ->
    Bin;
reverse_str(Bin, Start, Size, K) ->
    End = min(Start + K, Size),
    Reversed = reverse_slice(Bin, Start, End),
    NewBin = replace_slice(Bin, Start, End, Reversed),
    reverse_str(NewBin, Start + 2 * K, Size, K).

reverse_slice(Bin, Start, End) ->
    Slice = binary:part(Bin, Start, End - Start),
    list_to_binary(lists:reverse(binary_to_list(Slice))).

replace_slice(Bin, Start, End, Replacement) ->
    Prefix = binary:part(Bin, 0, Start),
    Suffix = binary:part(Bin, End, byte_size(Bin) - End),
    <<Prefix/binary, Replacement/binary, Suffix/binary>>.