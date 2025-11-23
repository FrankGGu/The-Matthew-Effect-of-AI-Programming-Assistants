-module(solution).
-export([minimizeMaximumEdgeWeight/2]).

init_dsu(N) ->
    Parent = maps:from_list([{I, I} || I <- lists:seq(1, N)]),
    Rank = maps:from_list([{I, 0} || I <- lists:seq(1, N)]),
    {Parent, Rank}.

find(I, Parent) ->
    case maps:get(I, Parent) of
        I -> {I, Parent};
        P ->
            {Root, UpdatedParentFromRecursiveCall} = find(P, Parent),
            {Root, maps:put(I, Root, UpdatedParentFromRecursiveCall)}
    end.

union(I, J, Parent, Rank) ->
    {RootI, Parent1} = find(I, Parent),
    {RootJ, Parent2} = find(J, Parent1),

    if
        RootI /= RootJ ->
            RankI = maps:get(RootI, Rank),
            RankJ = maps:get(RootJ, Rank),
            if
                RankI < RankJ ->
                    NewParent = maps:put(RootI, RootJ, Parent2),
                    {NewParent, Rank, true};
                RankI > RankJ ->
                    NewParent = maps:put(RootJ, RootI, Parent2),
                    {NewParent, Rank, true};
                true -> %% RankI == RankJ
                    NewParent = maps:put(RootJ, RootI, Parent2),
                    NewRank = maps:put(RootI, RankI + 1, Rank),
                    {NewParent, NewRank, true}
            end;
        true ->
            {Parent2, Rank, false} %% Already in the same set, Parent2 is the most updated parent map
    end.

minimizeMaximumEdgeWeight(N, Edges) ->
    %% Sort edges by weight in non-decreasing order
    SortedEdges = lists:sort(fun([_U1, _V1, W1], [_U2, _V2, W2]) -> W1 =< W2 end, Edges),

    {Parent0, Rank0} = init_dsu(N),

    %% Kruskal's algorithm
    %% Initial state: N components, 0 max weight
    kruskal(SortedEdges, Parent0, Rank0, N, 0).

kruskal([], _Parent, _Rank, _NumComponents, MaxWeight) ->
    MaxWeight;
kruskal([[U, V, W] | RestEdges], Parent, Rank, NumComponents, CurrentMaxWeight) ->
    {NewParent, NewRank, Merged} = union(U, V, Parent, Rank),
    if
        Merged -> %% A merge happened, this edge is part of the MST
            NewNumComponents = NumComponents - 1,
            NewMaxWeight = W, %% This edge's weight is the new maximum among chosen edges
            if
                NewNumComponents == 1 ->
                    NewMaxWeight; %% All nodes are connected, this is the answer
                true ->
                    kruskal(RestEdges, NewParent, NewRank, NewNumComponents, NewMaxWeight)
            end;
        true -> %% No merge, edge forms a cycle, skip it
            kruskal(RestEdges, NewParent, NewRank, NumComponents, CurrentMaxWeight)
    end.