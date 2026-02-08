-module(solution).
-export([number_of_ways_to_assign_weights/2]).

init_dsu(N) ->
    ParentMap = maps:from_list([{I, I} || I <- lists:seq(0, N-1)]),
    RankMap = maps:from_list([{I, 0} || I <- lists:seq(0, N-1)]),
    {ParentMap, RankMap}.

find(Node, ParentMap) ->
    Parent = maps:get(Node, ParentMap),
    if Parent == Node -> {Node, ParentMap};
    true ->
        {Root, NewParentMap} = find(Parent, ParentMap),
        {Root, maps:put(Node, Root, NewParentMap)}
    end.

union(Node1, Node2, ParentMap, RankMap, NumComponents) ->
    {Root1, PMap1} = find(Node1, ParentMap),
    {Root2, PMap2} = find(Node2, PMap1),
    if Root1 == Root2 -> {PMap2, RankMap, NumComponents};
    true ->
        Rank1 = maps:get(Root1, RankMap),
        Rank2 = maps:get(Root2, RankMap),
        if Rank1 < Rank2 ->
            {maps:put(Root1, Root2, PMap2), RankMap, NumComponents - 1};
        Rank1 > Rank2 ->
            {maps:put(Root2, Root1, PMap2), RankMap, NumComponents - 1};
        true -> %% Ranks are equal, arbitrarily make Root2 parent of Root1 and increment Root2's rank
            {maps:put(Root1, Root2, PMap2), maps:put(Root2, Rank2 + 1, RankMap), NumComponents - 1}
        end
    end.

power(Base, Exp, Mod) ->
    if Exp == 0 -> 1;
    Exp rem 2 == 0 ->
        Half = power(Base, Exp div 2, Mod),
        (Half * Half) rem Mod;
    true ->
        (Base * power(Base, Exp - 1, Mod)) rem Mod
    end.

number_of_ways_to_assign_weights(N, Edges) ->
    M = length(Edges),
    {ParentMap0, RankMap0} = init_dsu(N),
    NumComponents0 = N,

    %% Fold over edges to update DSU state and count connected components
    {_ParentMapF, _RankMapF, NumComponentsF} = lists:foldl(
        fun([U, V], {AccParentMap, AccRankMap, AccNumComponents}) ->
            union(U, V, AccParentMap, AccRankMap, AccNumComponents)
        end,
        {ParentMap0, RankMap0, NumComponents0},
        Edges
    ),

    %% The number of ways is 2^(M - N + C) modulo 10^9 + 7
    %% where M is number of edges, N is number of nodes, C is number of connected components.
    ResultExp = M - N + NumComponentsF,
    Mod = 1000000007,
    power(2, ResultExp, Mod).