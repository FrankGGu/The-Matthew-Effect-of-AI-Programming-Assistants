-module(sort_items).
-export([sort_items/3]).

sort_items(N, M, Group, BeforeItems) ->
    {GroupedItems, GroupDependencies} = prepare_data(N, M, Group, BeforeItems),

    case toposort(GroupDependencies) of
        {ok, GroupOrder} ->
            ItemsInGroupOrder = lists:flatten([
                case toposort(lists:get(GroupId, GroupedItems)) of
                    {ok, Items} -> Items;
                    _ -> []
                end
            || GroupId <- GroupOrder]),
            if length(ItemsInGroupOrder) =:= N then
                ItemsInGroupOrder
            else
                []
            end;
        _ ->
            []
    end.

prepare_data(N, M, Group, BeforeItems) ->
    GroupedItems = lists:foldl(
        fun(Item, Acc) ->
            GroupId = lists:nth(Item + 1, Group),
            case lists:keyfind(GroupId, 1, Acc) of
                false ->
                    lists:keyreplace(GroupId, 1, Acc, {GroupId, [Item]});
                {GroupId, Items} ->
                    lists:keyreplace(GroupId, 1, Acc, {GroupId, [Item | Items]})
            end
        end,
        lists:map(fun(I) -> {I, []} end, lists:seq(0, M - 1)),
        lists:seq(0, N - 1)
    ),

    GroupDependencies = lists:foldl(
        fun(Item, Acc) ->
            GroupId = lists:nth(Item + 1, Group),
            Before = lists:nth(Item + 1, BeforeItems),
            lists:foldl(
                fun(BeforeItem, Acc2) ->
                    BeforeGroupId = lists:nth(BeforeItem + 1, Group),
                    if GroupId /= BeforeGroupId andalso not lists:member(BeforeGroupId, lists:get(GroupId, Acc2, [])) then
                        lists:update(GroupId, fun(List) -> [BeforeGroupId | List] end, Acc2)
                    else
                        Acc2
                    end
                end,
                Acc,
                Before
            )
        end,
        dict:new(),
        lists:seq(0, N - 1)
    ),

    {lists:map(fun({GroupId, Items}) -> {GroupId, lists:zip(Items, lists:map(fun(_) -> [] end, Items)) } end, GroupedItems), GroupDependencies}.

toposort(Dependencies) ->
    try_toposort(dict:to_list(Dependencies), [], []).

try_toposort([], Visited, Acc) ->
    {ok, lists:reverse(Acc)};

try_toposort([{Node, []} | Rest], Visited, Acc) ->
    try_toposort(Rest, [Node | Visited], [Node | Acc]);

try_toposort([{Node, Deps} | Rest], Visited, Acc) ->
    FilteredDeps = [Dep || Dep <- Deps, not lists:member(Dep, Visited)],
    if length(FilteredDeps) == 0 then
        try_toposort(Rest, [Node | Visited], [Node | Acc])
    else
        NewDeps = lists:map(
            fun(Dep) ->
                case lists:keyfind(Dep, 1, Rest) of
                    false ->
                        case lists:keyfind(Dep, 1, dict:to_list(Dependencies)) of
                            false -> {Dep, []};
                            {Dep, DepDeps} -> {Dep, DepDeps}
                        end;
                    {_, DepDeps} -> {Dep, DepDeps}
                end
            end,
            FilteredDeps
        ),

        try_toposort(NewDeps ++ [{Node, Deps} | Rest], Visited, Acc)
    end.

try_toposort(_, _, _) ->
    {error, cycle}.