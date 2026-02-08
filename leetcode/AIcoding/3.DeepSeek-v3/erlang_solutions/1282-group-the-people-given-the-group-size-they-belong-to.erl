-spec group_the_people(GroupSizes :: [integer()]) -> [[integer()]].
group_the_people(GroupSizes) ->
    {Map, _} = lists:foldl(
        fun(Size, {Acc, Index}) ->
            Key = Size,
            case maps:find(Key, Acc) of
                {ok, List} -> 
                    NewList = [Index | List],
                    NewAcc = maps:put(Key, NewList, Acc),
                    {NewAcc, Index + 1};
                error -> 
                    NewAcc = maps:put(Key, [Index], Acc),
                    {NewAcc, Index + 1}
            end
        end,
        {maps:new(), 0},
        GroupSizes
    ),
    lists:foldl(
        fun({Size, Indices}, Acc) ->
            {Groups, _} = lists:foldl(
                fun(Idx, {Grps, Current}) ->
                    case Current of
                        [] -> {Grps, [Idx]};
                        List when length(List) < Size -> {Grps, [Idx | List]};
                        List -> {[List | Grps], [Idx]}
                    end
                end,
                {[], []},
                lists:reverse(Indices)
            ),
            case Groups of
                [] -> [[lists:reverse(Indices)] | Acc];
                _ -> lists:reverse([lists:reverse(Current) | Groups]) ++ Acc
            end
        end,
        [],
        maps:to_list(Map)
    ).