-spec license_key_formatting(S :: unicode:unicode_binary(), K :: integer()) -> unicode:unicode_binary().
license_key_formatting(S, K) ->
    Clean = re:replace(S, "-", "", [global, {return, binary}]),
    CleanUpper = string:uppercase(Clean),
    Len = byte_size(CleanUpper),
    FirstGroupLen = case Len rem K of
                        0 -> K;
                        N -> N
                    end,
    FirstGroup = binary:part(CleanUpper, 0, FirstGroupLen),
    Rest = binary:part(CleanUpper, FirstGroupLen, Len - FirstGroupLen),
    Formatted = format_rest(Rest, K, <<>>),
    case byte_size(Rest) of
        0 -> FirstGroup;
        _ -> <<FirstGroup/binary, "-", Formatted/binary>>
    end.

format_rest(<<>>, _, Acc) -> Acc;
format_rest(Rest, K, Acc) ->
    Current = binary:part(Rest, 0, K),
    Remaining = binary:part(Rest, K, byte_size(Rest) - K),
    case byte_size(Acc) of
        0 -> format_rest(Remaining, K, Current);
        _ -> format_rest(Remaining, K, <<Acc/binary, "-", Current/binary>>)
    end.