-spec compare_version(Version1 :: unicode:unicode_binary(), Version2 :: unicode:unicode_binary()) -> integer().
compare_version(Version1, Version2) ->
    compare_version(string:tokens(Version1, "."), string:tokens(Version2, ".")).

compare_version([], []) -> 0;
compare_version([], [_ | _]) -> -1;
compare_version([_ | _], []) -> 1;
compare_version([V1 | Rest1], [V2 | Rest2]) ->
    case string:to_integer(V1) - string:to_integer(V2) of
        0 -> compare_version(Rest1, Rest2);
        Diff when Diff < 0 -> -1;
        Diff -> 1
    end.
