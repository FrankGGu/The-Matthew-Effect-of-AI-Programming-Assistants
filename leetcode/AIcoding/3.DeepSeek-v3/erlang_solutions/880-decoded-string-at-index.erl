-spec decode_at_index(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
decode_at_index(S, K) ->
    Size = 0,
    {FinalSize, _} = calculate_size(S, Size),
    decode(S, K, FinalSize).

calculate_size([], Size) -> {Size, Size};
calculate_size([H | T], Size) ->
    case H >= $a andalso H =< $z of
        true -> calculate_size(T, Size + 1);
        false -> 
            Digit = H - $0,
            NewSize = Size * Digit,
            calculate_size(T, NewSize)
    end.

decode([], _, _) -> <<>>;
decode([H | T], K, Size) ->
    case H >= $a andalso H =< $z of
        true ->
            if
                K =:= Size orelse K =:= 0 -> <<H>>;
                true -> decode(T, K, Size - 1)
            end;
        false ->
            Digit = H - $0,
            NewSize = Size div Digit,
            if
                K rem NewSize =:= 0 -> decode(T, NewSize, NewSize);
                true -> decode(T, K rem NewSize, NewSize)
            end
    end.