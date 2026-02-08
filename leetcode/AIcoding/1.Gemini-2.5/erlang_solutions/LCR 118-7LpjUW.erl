-module(solution).
-export([findRedundantConnection/1]).

find(Node, ParentMap) ->
    case maps:get(Node, ParentMap, Node) of
        Node -> {Node, ParentMap};
        Parent ->
            {Root, UpdatedParentMap1} = find(Parent, ParentMap),
            {Root, maps:put(Node, Root, UpdatedParentMap1)}
    end.

union(Node1, Node2, ParentMap) ->
    {Root1, UpdatedParentMap1} = find(Node1, ParentMap),
    {Root2, UpdatedParentMap2} = find(Node2, UpdatedParentMap1),
    if
        Root1 == Root2 ->
            {redundant, UpdatedParentMap2};
        true ->
            {ok, maps:put(Root1, Root2, UpdatedParentMap2)}
    end.

findRedundantConnection(Edges) ->
    find_redundant(Edges, maps:new()).

find_redundant([[U, V] | Rest], ParentMap) ->
    case union(U, V, ParentMap) of
        {redundant, _} ->
            [U, V];
        {ok, NewParentMap} ->
            find_redundant(Rest, NewParentMap)
    end.