-module(solution).
-export([max_removable_edges/2]).

init_dsu(N) ->
    ParentMap = lists:foldl(fun(I, Acc) -> dict:store(I, I, Acc) end, dict:new(), lists:seq(1, N)),
    {N, ParentMap}.

find(Node, ParentMap) ->
    Parent = dict:fetch(Node, ParentMap),
    if
        Parent == Node -> {Node, ParentMap};
        true ->
            {Root, UpdatedParentMap} = find(Parent, ParentMap),
            {Root, dict:store(Node, Root, UpdatedParentMap)} % Path compression
    end.

union(Node1, Node2, DSUState) ->
    {NumComponents, ParentMap} = DSUState,
    {Root1, ParentMap1} = find(Node1, ParentMap),
    {Root2, ParentMap2} = find(Node2, ParentMap1), % Use ParentMap1 for finding Root2 to propagate path compression
    if
        Root1 == Root2 -> {false, {NumComponents, ParentMap2}}; % Already in the same set, return latest ParentMap
        true ->
            NewParentMap = dict:store(Root1, Root2, ParentMap2), % Union by arbitrary root
            NewNumComponents = NumComponents - 1,
            {true, {NewNumComponents, NewParentMap}}
    end.

max_removable_edges(N, Edges) ->
    AliceDSU_initial = init_dsu(N),
    BobDSU_initial = init_dsu(N),

    Type3Edges = lists:filter(fun([Type, _, _]) -> Type == 3 end, Edges),
    Type1Edges = lists:filter(fun([Type, _, _]) -> Type == 1 end, Edges),
    Type2Edges = lists:filter(fun([Type, _, _]) -> Type == 2 end, Edges),

    % Process Type 3 edges first
    % Accumulator: {KeptEdges, AliceDSU, BobDSU}
    {KeptEdges1, AliceDSU1, BobDSU1} = lists:foldl(
        fun([_, U, V], {AccKept, AccAliceDSU, AccBobDSU}) ->
            {AliceUnited, TmpAliceDSU} = union(U, V, AccAliceDSU),
            {BobUnited, TmpBobDSU} = union(U, V, AccBobDSU),
            if
                AliceUnited or BobUnited ->
                    {AccKept + 1, TmpAliceDSU, TmpBobDSU};
                true ->
                    {AccKept, AccAliceDSU, AccBobDSU}
            end
        end,
        {0, AliceDSU_initial, BobDSU_initial},
        Type3Edges
    ),

    % Process Type 1 edges for Alice
    % Accumulator: {KeptEdges, AliceDSU, BobDSU (unchanged)}
    {KeptEdges2, AliceDSU2, _BobDSU_unchanged1} = lists:foldl(
        fun([_, U, V], {AccKept, AccAliceDSU, AccBobDSU}) ->
            {AliceUnited, TmpAliceDSU} = union(U, V, AccAliceDSU),
            if
                AliceUnited ->
                    {AccKept + 1, TmpAliceDSU, AccBobDSU};
                true ->
                    {AccKept, AccAliceDSU, AccBobDSU}
            end
        end,
        {KeptEdges1, AliceDSU1, BobDSU1},
        Type1Edges
    ),

    % Process Type 2 edges for Bob
    % Accumulator: {KeptEdges, AliceDSU (unchanged), BobDSU}
    {FinalKeptEdges, _AliceDSU_unchanged2, BobDSU2} = lists:foldl(
        fun([_, U, V], {AccKept, AccAliceDSU, AccBobDSU}) ->
            {BobUnited, TmpBobDSU} = union(U, V, AccBobDSU),
            if
                BobUnited ->
                    {AccKept + 1, AccAliceDSU, TmpBobDSU};
                true ->
                    {AccKept, AccAliceDSU, AccBobDSU}
            end
        end,
        {KeptEdges2, AliceDSU2, BobDSU1},
        Type2Edges
    ),

    {AliceComponents, _} = AliceDSU2,
    {BobComponents, _} = BobDSU2,

    if
        AliceComponents == 1 and BobComponents == 1 ->
            length(Edges) - FinalKeptEdges;
        true ->
            -1
    end.