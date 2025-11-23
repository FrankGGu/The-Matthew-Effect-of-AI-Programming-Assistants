-module(mst_edges).
-export([find_critical_and_pseudo_critical_edges/1]).

find_critical_and_pseudoCritical_edges(Edges) ->
    Nodes = lists:usort(lists:flatten([A || [A, _, _] <- Edges])),
    N = length(Nodes),
    MST = mst(Edges, N),
    MSTWeight = mst_weight(MST),
    Critical = [],
    PseudoCritical = [],
    find_critical_and_pseudoCritical_edges(Edges, N, MSTWeight, [], [], 0).

mst(Edges, N) ->
    SortedEdges = lists:sort(Edges),
    Parent = array:new(N, {default, -1}),
    TotalWeight = 0,
    MST = [],
    mst_helper(SortedEdges, Parent, TotalWeight, MST).

mst_helper([], _Parent, _TotalWeight, MST) ->
    MST;
mst_helper([Edge | Rest], Parent, TotalWeight, MST) ->
    [U, V, W] = Edge,
    UIndex = U - 1,
    VIndex = V - 1,
    RootU = find_root(Parent, UIndex),
    RootV = find_root(Parent, VIndex),
    if
        RootU /= RootV ->
            Union(Parent, RootU, RootV),
            mst_helper(Rest, Parent, TotalWeight + W, [Edge | MST]);
        true ->
            mst_helper(Rest, Parent, TotalWeight, MST)
    end.

find_root(Parent, X) ->
    if
        array:get(X, Parent) == -1 ->
            X;
        true ->
            Root = find_root(Parent, array:get(X, Parent)),
            array:set(X, Root, Parent),
            Root
    end.

union(Parent, X, Y) ->
    array:set(Y, X, Parent).

mst_weight(MST) ->
    lists:sum([W || [_, _, W] <- MST]).

find_critical_and_pseudoCritical_edges(_, _, _, Critical, PseudoCritical, _) ->
    [Critical, PseudoCritical].