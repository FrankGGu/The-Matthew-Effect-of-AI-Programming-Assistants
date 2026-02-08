mergeKLists(Lists) ->
    case lists:filter(fun(L) -> L =/= [] end, Lists) of
        [] -> [];
        NonEmptyLists ->
            {Heads, Tails} = lists:unzip(lists:map(fun([H|T]) -> {H, T} end, NonEmptyLists)),
            Min = lists:min(Heads),
            Index = index_of(Min, Heads),
            {Before, [MinList|After]} = lists:split(Index, NonEmptyLists),
            NewList = case MinList of
                [_|T] -> T;
                [] -> []
            end,
            [Min | mergeKLists(lists:append([Before, [NewList], After]))]
    end.

index_of(Item, List) -> index_of(Item, List, 0).

index_of(Item, [Item|_], Index) -> Index;
index_of(Item, [_|T], Index) -> index_of(Item, T, Index + 1).