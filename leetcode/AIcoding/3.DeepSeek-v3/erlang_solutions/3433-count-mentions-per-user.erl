-spec count_mentions(Mentions :: [unicode:unicode_binary()]) -> #{unicode:unicode_binary() => integer()}.
count_mentions(Mentions) ->
    lists:foldl(
        fun(Mention, Acc) ->
            case binary:split(Mention, <<"@">>, [global]) of
                [_, User | _] ->
                    maps:update_with(User, fun(V) -> V + 1 end, 1, Acc);
                _ ->
                    Acc
            end
        end,
        #{},
        Mentions
    ).