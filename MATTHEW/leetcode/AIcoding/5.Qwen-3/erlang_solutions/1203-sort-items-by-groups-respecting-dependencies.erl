-module(solution).
-export([sort_items/2]).

sort_items(NumItems, Dependencies) ->
    [Group | _] = Dependencies,
    GroupSize = length(Group),
    Groups = lists:seq(1, GroupSize),
    Adj = maps:new(),
    InDegree = maps:new(),
    ItemToGroup = maps:new(),
    {Adj1, InDegree1, ItemToGroup1} = build_graph(NumItems, Dependencies, Adj, InDegree, ItemToGroup),
    TopoGroups = topological_sort(Groups, Adj1, InDegree1),
    TopoItems = [],
    lists:foldl(fun(GroupID, Acc) -> 
        Items = get_items_by_group(GroupID, ItemToGroup1),
        TopoItems1 = topological_sort_items(Items, Adj1, InDegree1),
        Acc ++ TopoItems1
    end, TopoItems, TopoGroups).

build_graph(_, [], Adj, InDegree, ItemToGroup) ->
    {Adj, InDegree, ItemToGroup};

build_graph(NumItems, [[Item, Group] | Rest], Adj, InDegree, ItemToGroup) ->
    NewItemToGroup = maps:put(Item, Group, ItemToGroup),
    build_graph(NumItems, Rest, Adj, InDegree, NewItemToGroup);

build_graph(NumItems, [[Group1, Group2] | Rest], Adj, InDegree, ItemToGroup) ->
    case maps:is_key(Group1, Adj) of
        true -> 
            Adj1 = maps:update(Group1, [Group2 | maps:get(Group1, Adj)], Adj);
        false -> 
            Adj1 = maps:put(Group1, [Group2], Adj)
    end,
    case maps:is_key(Group2, InDegree) of
        true -> 
            InDegree1 = maps:update(Group2, maps:get(Group2, InDegree) + 1, InDegree);
        false -> 
            InDegree1 = maps:put(Group2, 1, InDegree)
    end,
    build_graph(NumItems, Rest, Adj1, InDegree1, ItemToGroup).

topological_sort([], _, _) ->
    [];

topological_sort(Groups, Adj, InDegree) ->
    Queue = lists:filter(fun(G) -> maps:get(G, InDegree, 0) == 0 end, Groups),
    Result = [],
    topological_sort_helper(Queue, Adj, InDegree, Result).

topological_sort_helper([], _, _, Result) ->
    Result;

topological_sort_helper([G | Rest], Adj, InDegree, Result) ->
    Result1 = Result ++ [G],
    Neighbors = maps:get(G, Adj, []),
    InDegree1 = lists:foldl(fun(Neighbor, Acc) ->
        maps:update(Neighbor, maps:get(Neighbor, Acc) - 1, Acc)
    end, InDegree, Neighbors),
    Queue = lists:foldl(fun(Neighbor, Acc) ->
        case maps:get(Neighbor, InDegree1, 0) of
            0 -> [Neighbor | Acc];
            _ -> Acc
        end
    end, Rest, Neighbors),
    topological_sort_helper(Queue, Adj, InDegree1, Result1).

get_items_by_group(GroupID, ItemToGroup) ->
    lists:filter(fun(Item) -> maps:get(Item, ItemToGroup) == GroupID end, maps:keys(ItemToGroup)).

topological_sort_items(Items, Adj, InDegree) ->
    NodeToIndex = maps:from_list(lists:zip(Items, lists:seq(1, length(Items)))),
    NewAdj = maps:map(fun(_K, V) -> lists:map(fun(X) -> maps:get(X, NodeToIndex) end, V) end, Adj),
    NewInDegree = maps:map(fun(K, V) -> maps:get(K, NodeToIndex) end, InDegree),
    Queue = lists:filter(fun(I) -> maps:get(I, NewInDegree, 0) == 0 end, lists:seq(1, length(Items))),
    Result = [],
    topological_sort_items_helper(Queue, NewAdj, NewInDegree, Result, NodeToIndex).

topological_sort_items_helper([], _, _, Result, _) ->
    Result;

topological_sort_items_helper([I | Rest], Adj, InDegree, Result, NodeToIndex) ->
    Result1 = Result ++ [lists:keyfind(I, 2, maps:to_list(NodeToIndex))],
    Neighbors = maps:get(I, Adj, []),
    InDegree1 = lists:foldl(fun(Neighbor, Acc) ->
        maps:update(Neighbor, maps:get(Neighbor, Acc) - 1, Acc)
    end, InDegree, Neighbors),
    Queue = lists:foldl(fun(Neighbor, Acc) ->
        case maps:get(Neighbor, InDegree1, 0) of
            0 -> [Neighbor | Acc];
            _ -> Acc
        end
    end, Rest, Neighbors),
    topological_sort_items_helper(Queue, Adj, InDegree1, Result1, NodeToIndex).