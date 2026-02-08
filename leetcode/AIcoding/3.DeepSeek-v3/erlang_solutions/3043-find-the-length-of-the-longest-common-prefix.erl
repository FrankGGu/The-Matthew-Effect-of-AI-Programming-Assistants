-spec longest_common_prefix(Strs :: [unicode:unicode_binary()]) -> unicode:unicode_binary().
longest_common_prefix(Strs) ->
    case Strs of
        [] -> <<>>;
        [First | Rest] ->
            lists:foldl(fun(Str, Prefix) ->
                common_prefix(Prefix, Str)
            end, First, Rest)
    end.

common_prefix(<<>>, _) -> <<>>;
common_prefix(_, <<>>) -> <<>>;
common_prefix(<<C, Rest1/binary>>, <<C, Rest2/binary>>) ->
    <<C, (common_prefix(Rest1, Rest2))/binary>>;
common_prefix(_, _) -> <<>>.