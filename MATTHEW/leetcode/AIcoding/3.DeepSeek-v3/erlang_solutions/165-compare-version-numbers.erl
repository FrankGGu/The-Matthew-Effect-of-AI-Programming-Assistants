-spec compare_version(Version1 :: unicode:unicode_binary(), Version2 :: unicode:unicode_binary()) -> integer().
compare_version(Version1, Version2) ->
    V1Parts = binary:split(Version1, <<".">>, [global]),
    V2Parts = binary:split(Version2, <<".">>, [global]),
    compare_parts(V1Parts, V2Parts).

compare_parts([], []) -> 0;
compare_parts([], V2Parts) -> compare_remaining(V2Parts, 0);
compare_parts(V1Parts, []) -> compare_remaining(V1Parts, 1);
compare_parts([V1 | Rest1], [V2 | Rest2]) ->
    N1 = binary_to_integer(V1),
    N2 = binary_to_integer(V2),
    if
        N1 > N2 -> 1;
        N1 < N2 -> -1;
        true -> compare_parts(Rest1, Rest2)
    end.

compare_remaining([], _) -> 0;
compare_remaining([H | T], Sign) ->
    case binary_to_integer(H) of
        0 -> compare_remaining(T, Sign);
        _ -> Sign
    end.