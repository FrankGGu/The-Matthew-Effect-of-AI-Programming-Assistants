-module(solution).
-export([solve/3]).

find(ParentMap, Node) ->
    case maps:get(Node, ParentMap) of
        Node -> {ParentMap, Node};
        Parent ->
            {NewParentMap1, Root} = find(ParentMap, Parent),
            {maps:put(Node, Root, NewParentMap1), Root}
    end.

union(ParentMap, Node1, Node2) ->
    {ParentMap1, Root1} = find(ParentMap, Node1),
    {ParentMap2, Root2} = find(ParentMap1, Node2),
    if
        Root1 =/= Root2 ->
            maps:put(Root2, Root1, ParentMap2);
        true ->
            ParentMap2
    end.

solve(N, Edges, Queries) ->
    InitialParentMap = maps:from_list([{I, I} || I <- lists:seq(1, N)]),

    FinalParentMap = lists:foldl(
        fun([U, V], AccParentMap) ->
            union(AccParentMap, U, V)
        end,
        InitialParentMap,
        Edges
    ),

    lists:map(
        fun([U, V]) ->
            {_, RootU} = find(FinalParentMap, U),
            {_, RootV} = find(FinalParentMap, V),
            RootU =:= RootV
        end,
        Queries
    ).