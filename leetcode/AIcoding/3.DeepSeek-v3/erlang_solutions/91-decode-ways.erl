-spec num_decodings(S :: unicode:unicode_binary()) -> integer().
num_decodings(S) ->
    case S of
        <<>> -> 0;
        _ ->
            DP = array:new([{size, byte_size(S) + 1}, {default, 0}]),
            DP1 = array:set(0, 1, DP),
            DP2 = case binary:first(S) of
                $0 -> DP1;
                _ -> array:set(1, 1, DP1)
            end,
            num_decodings(S, 2, DP2)
    end.

num_decodings(S, I, DP) when I > byte_size(S) ->
    array:get(byte_size(S), DP);
num_decodings(S, I, DP) ->
    OneDigit = binary:at(S, I - 1),
    TwoDigit = binary:part(S, I - 2, 2),
    Val1 = case OneDigit of
        $0 -> 0;
        _ -> array:get(I - 1, DP)
    end,
    Val2 = case binary_to_integer(TwoDigit) of
        N when N >= 10, N =< 26 -> array:get(I - 2, DP);
        _ -> 0
    end,
    NewDP = array:set(I, Val1 + Val2, DP),
    num_decodings(S, I + 1, NewDP).