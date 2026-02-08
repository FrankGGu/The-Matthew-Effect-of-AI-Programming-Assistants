-module(solution).
-export([sort_items/3]).

sort_items(N, M, L) ->
    Groups = lists:duplicate(M, []),
    {Items, GroupMap} = lists:foldl(fun({I, G}, {AccItems, AccGroupMap}) ->
        {AccItems ++ [I], lists:update_element(G + 1, AccGroupMap, [I | lists:nth(G + 1, AccGroupMap)])}
    end, {[], Groups}, L),
    ItemGraph = build_graph(Items, GroupMap),
    GroupGraph = build_group_graph(GroupMap),
    {ItemOrder, ItemOk} = topo_sort(ItemGraph, N),
    {GroupOrder, GroupOk} = topo_sort(GroupGraph, M),
    if ItemOk andalso GroupOk -> 
        {ItemOrder, GroupOrder};
       true -> 
        []
    end.

build_graph(Items, GroupMap) ->
    lists:foldl(fun({X, Y}, Acc) ->
        case lists:nth(Y + 1, GroupMap) of
            [] -> Acc;
            _ -> lists:keystore(X, 1, Acc, {X, lists:nth(Y + 1, GroupMap) ++ [Y]})
        end
    end, lists:duplicate(length(Items), []), Items).

build_group_graph(GroupMap) ->
    lists:foldl(fun({X, Y}, Acc) ->
        lists:keystore(X, 1, Acc, {X, lists:nth(Y + 1, Acc) ++ [Y]})
    end, lists:duplicate(length(GroupMap), []), GroupMap).

topo_sort(Graph, N) ->
    Visited = lists:duplicate(N, false),
    Result = [],
    lists:foldl(fun(Node, Acc) -> 
        case dfs(Node, Graph, Visited, Acc) of
            {Ok, Res} -> Res;
            {Fail, _} -> {Fail, []}
        end
    end, {ok, Result}, lists:seq(0, N - 1)).

dfs(Node, Graph, Visited, Acc) ->
    case lists:nth(Node + 1, Visited) of
        true -> {ok, Acc};
        false -> 
            Visited1 = lists:update_element(Node + 1, Visited, true),
            {Status, Res} = lists:foldl(fun(NextNode, {Stat, R}) ->
                if Stat == ok -> 
                    dfs(NextNode, Graph, Visited1, R);
                true -> 
                    {Stat, R}
                end
            end, {ok, Acc}, lists:nth(Node + 1, Graph)),
            case Status of
                ok -> {ok, [Node | Res]};
                _ -> {Fail, []}
            end
    end.