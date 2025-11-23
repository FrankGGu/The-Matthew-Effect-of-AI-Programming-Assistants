-spec longest_unequal_adjacent_groups_subsequence_i(Names :: [unicode:unicode_binary()], Groups :: [integer()]) -> [unicode:unicode_binary()].
longest_unequal_adjacent_groups_subsequence_i(Names, Groups) ->
    {_, Result} = lists:foldl(fun
        ({Name, Group}, {PrevGroup, Acc}) when Group =/= PrevGroup ->
            {Group, [Name | Acc]};
        (_, Acc) ->
            Acc
    end, {-1, []}, lists:zip(Names, Groups)),
    lists:reverse(Result).