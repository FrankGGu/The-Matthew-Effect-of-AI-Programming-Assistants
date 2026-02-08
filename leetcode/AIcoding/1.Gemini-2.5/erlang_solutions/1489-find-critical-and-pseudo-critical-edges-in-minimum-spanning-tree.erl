-module(solution).
-export([findCriticalAndPseudoCriticalEdges/2]).

make_set_dsu(N) ->
    Parents = maps:from_list([{I, I} || I <- lists:seq(0, N-1)]),
    Ranks = maps:from_list([{I, 0} || I <- lists:seq(0, N-1)]),
    {Parents, Ranks}.

find_dsu(Node, Parents) ->
    Parent = maps:get(Node, Parents),
    if
        Parent == Node -> {Node, Parents};
        true ->
            {Root, NewParents} = find_dsu(Parent, Parents),
            {Root, maps:put(Node, Root, NewParents)}
    end.

union_dsu(Node1, Node2, {Parents, Ranks}) ->
    {Root1, Parents1} = find_dsu(Node1, Parents),
    {Root2, Parents2} = find_dsu(Node2, Parents1),

    if
        Root1 /= Root2 ->
            Rank1 = maps:get(Root1, Ranks),
            Rank2 = maps:get(Root2, Ranks),
            NewParents =
                if
                    Rank1 < Rank2 -> maps:put(Root1, Root2, Parents2);
                    Rank1 > Rank2 -> maps:put(Root2, Root1, Parents2);
                    true ->
                        maps:put(Root2, Root1, Parents2)
                end,
            NewRanks =
                if
                    Rank1 == Rank2 -> maps:put(Root1, Rank1 + 1, Ranks);
                    true -> Ranks
                end,
            {{NewParents, NewRanks}, true};
        true ->
            {{Parents2, Ranks}, false}
    end.

kruskal(N, Edges, ExcludeIdx, ForceEdge) ->
    DSUState = make_set_dsu(N),

    ForcedWeight = 0,
    ForcedEdgesCount = 0,
    ForcedDSUState = DSUState,

    {ForcedDSUState1, ForcedWeight1, ForcedEdgesCount1} =
        case ForceEdge of
            {W, U, V, Idx} when Idx /= ExcludeIdx ->
                {{NewParents, NewRanks}, _Success} = union_dsu(U, V, DSUState),
                {{NewParents, NewRanks}, W, 1};
            _ ->
                {ForcedDSUState, ForcedWeight, ForcedEdgesCount}
        end,

    SortedEdges = lists:sort(fun({W1,_,_,_}, {W2,_,_,_}) -> W1 =< W2 end, Edges),

    {FinalWeight, FinalEdgesCount, _} =
        lists:foldl(fun({W, U, V, Idx}, {AccWeight, AccEdgesCount, AccDSUState}) ->
            if
                Idx == ExcludeIdx ->
                    {AccWeight, AccEdgesCount, AccDSUState};
                Idx == case ForceEdge of {_,_,_,ForcedIdx} -> ForcedIdx; _ -> -2 end ->
                    {AccWeight, AccEdgesCount, AccDSUState};
                true ->
                    {{NewParents, NewRanks}, Success} = union_dsu(U, V, AccDSUState),
                    if
                        Success ->
                            {AccWeight + W, AccEdgesCount + 1, {NewParents, NewRanks}};
                        true ->
                            {AccWeight, AccEdgesCount, {NewParents, NewRanks}}
                    end
            end
        end, {ForcedWeight1, ForcedEdgesCount1, ForcedDSUState1}, SortedEdges),

    if
        FinalEdgesCount == N - 1 -> FinalWeight;
        true -> infinity
    end.

findCriticalAndPseudoCriticalEdges(N, Edges) ->
    IndexedEdges = lists:map(fun([U, V, W], Idx) -> {W, U, V, Idx} end, Edges, lists:seq(0, length(Edges) - 1)),

    MinMSTWeight = kruskal(N, IndexedEdges, -1, none),

    CriticalEdges = [],
    PseudoCriticalEdges = [],

    lists:foldl(fun({W, U, V, Idx}, {AccCritical, AccPseudo}) ->
        WeightWithoutEdge = kruskal(N, IndexedEdges, Idx, none),
        if
            WeightWithoutEdge > MinMSTWeight ->
                {[Idx | AccCritical], AccPseudo};
            true ->
                WeightWithForcedEdge = kruskal(N, IndexedEdges, -1, {W, U, V, Idx}),
                if
                    WeightWithForcedEdge == MinMSTWeight ->
                        {AccCritical, [Idx | AccPseudo]};
                    true ->
                        {AccCritical, AccPseudo}
                end
        end
    end, {CriticalEdges, PseudoCriticalEdges}, IndexedEdges).