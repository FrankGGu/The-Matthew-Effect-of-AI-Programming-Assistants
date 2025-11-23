-spec count_substrings(S :: unicode:unicode_binary(), K :: integer()) -> integer().
count_substrings(S, K) ->
    Bin = unicode:characters_to_binary(S),
    Len = byte_size(Bin),
    Count = 0,
    count_substrings(Bin, Len, K, Count).

count_substrings(_, 0, _, Count) -> Count;
count_substrings(Bin, Len, K, Count) ->
    NewCount = count_for_length(Bin, Len, K, 0),
    count_substrings(Bin, Len - 1, K, Count + NewCount).

count_for_length(Bin, SubLen, K, Count) when byte_size(Bin) >= SubLen ->
    Sub = binary:part(Bin, 0, SubLen),
    Freq = frequency_map(Sub, #{}),
    case has_k_frequency(Freq, K) of
        true -> count_for_length(binary:part(Bin, 1, byte_size(Bin) - 1), SubLen, K, Count + 1);
        false -> count_for_length(binary:part(Bin, 1, byte_size(Bin) - 1), SubLen, K, Count)
    end;
count_for_length(_, _, _, Count) -> Count.

frequency_map(<<>>, Map) -> Map;
frequency_map(<<C, Rest/binary>>, Map) ->
    case maps:get(C, Map, 0) of
        Val -> frequency_map(Rest, Map#{C => Val + 1})
    end.

has_k_frequency(Freq, K) ->
    maps:fold(fun(_, V, Acc) -> Acc or (V == K) end, false, Freq).