-module(solution).
-export([sort_items/3]).

sort_items(N, M, Group, BeforeItems) ->
    Group1 = lists:map(fun(G) -> if G == -1 -> M + G + 1; true -> G end end, Group),
    GroupSize = lists:max(Group1) + 1,
    GroupGraph = lists:duplicate(GroupSize, []),
    GroupIndegree = lists:duplicate(GroupSize, 0),
    ItemGraph = lists:duplicate(N, []),
    ItemIndegree = lists:duplicate(N, 0),
    {GroupGraph1, GroupIndegree1, ItemGraph1, ItemIndegree1} = 
        lists:foldl(fun(I, {GG, GI, IG, II}) ->
            GroupI = lists:nth(I + 1, Group1),
            lists:foldl(fun(J, {GG2, GI2, IG2, II2}) ->
                GroupJ = lists:nth(J + 1, Group1),
                IG3 = case lists:nth(J + 1, IG2) of
                    L -> setelement(I + 1, IG2, [J | L])
                end,
                II3 = increment(II2, I),
                if 
                    GroupI /= GroupJ ->
                        GG3 = case lists:nth(GroupJ + 1, GG2) of
                            L2 -> setelement(GroupI + 1, GG2, [GroupJ | L2])
                        end,
                        GI3 = increment(GI2, GroupI),
                        {GG3, GI3, IG3, II3};
                    true ->
                        {GG2, GI2, IG3, II3}
                end
            end, {GG, GI, IG, II}, lists:nth(I + 1, BeforeItems))
        end, {GroupGraph, GroupIndegree, ItemGraph, ItemIndegree}, lists:seq(0, N - 1)),

    GroupOrder = topological_sort(GroupGraph1, GroupIndegree1),
    case GroupOrder of
        false -> [];
        _ ->
            GroupToItems = lists:foldl(fun(I, Acc) ->
                G = lists:nth(I + 1, Group1),
                case lists:keyfind(G, 1, Acc) of
                    false -> [{G, [I]} | Acc];
                    {G, L} -> lists:keyreplace(G, 1, Acc, {G, [I | L]})
                end
            end, [], lists:seq(0, N - 1)),
            lists:foldl(fun(G, Acc) ->
                case lists:keyfind(G, 1, GroupToItems) of
                    false -> Acc;
                    {G, Items} ->
                        ItemOrder = topological_sort(
                            lists:map(fun(Item) -> lists:nth(Item + 1, ItemGraph1) end, Items),
                            lists:map(fun(Item) -> lists:nth(Item + 1, ItemIndegree1) end, Items)),
                        case ItemOrder of
                            false -> [];
                            _ -> Acc ++ ItemOrder
                        end
                end
            end, [], GroupOrder)
    end.

topological_sort(Graph, Indegree) ->
    Queue = [I || {I, V} <- lists:zip(lists:seq(0, length(Indegree) - 1), Indegree), V == 0],
    sort(Graph, Indegree, Queue, []).

sort(_, _, [], Result) -> lists:reverse(Result);
sort(Graph, Indegree, [Node | Queue], Result) ->
    {NewIndegree, NewQueue} = 
        lists:foldl(fun(Neighbor, {Indegree1, Queue1}) ->
            NewIndegree = decrement(Indegree1, Neighbor),
            if 
                lists:nth(Neighbor + 1, NewIndegree) == 0 ->
                    {NewIndegree, Queue1 ++ [Neighbor]};
                true ->
                    {NewIndegree, Queue1}
            end
        end, {Indegree, Queue}, lists:nth(Node + 1, Graph)),
    sort(Graph, NewIndegree, NewQueue, [Node | Result]);
sort(_, _, _, _) -> false.

increment(List, Index) ->
    setelement(Index + 1, List, lists:nth(Index + 1, List) + 1).

decrement(List, Index) ->
    setelement(Index + 1, List, lists:nth(Index + 1, List) - 1).