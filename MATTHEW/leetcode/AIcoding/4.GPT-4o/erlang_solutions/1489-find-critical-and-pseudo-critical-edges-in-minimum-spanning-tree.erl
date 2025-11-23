-module(solution).
-export([findCriticalAndPseudoCriticalEdges/2]).

findCriticalAndPseudoCriticalEdges(N, Edges) ->
    Edges1 = lists:map(fun({A, B, C, Index}) -> {C, A, B, Index} end, Edges),
    Edges2 = lists:sort(fun({C1, _, _, _}, {C2, _, _, _}) -> C1 < C2 end, Edges1),
    {MST, Weight} = kruskal(N, Edges2),
    lists:foldl(fun({C, A, B, Index}, {Critical, Pseudo}) ->
                     case check_critical(N, Edges2, A, B, Weight, Index) of
                         true -> {[Index | Critical], Pseudo};
                         false -> 
                             case check_pseudo(N, Edges2, A, B, Weight, Index) of
                                 true -> {Critical, [Index | Pseudo]};
                                 false -> {Critical, Pseudo}
                             end
                     end
                 end, {[], []}, Edges1).

kruskal(N, Edges) ->
    {Parent, Rank} = initialize(N),
    {MST, Weight} = lists:foldl(fun({C, A, B, _}, {MST, Weight}) ->
                                    case union(A, B, Parent, Rank) of
                                        {true, NewParent, NewRank} ->
                                            {MST + 1, Weight + C, {NewParent, NewRank}};
                                        false -> {MST, Weight}
                                    end
                                end, {0, 0}, Edges),
    {MST, Weight}.

initialize(N) ->
    Parent = lists:map(fun(I) -> I end, lists:seq(0, N - 1)),
    Rank = lists:map(fun(_) -> 0 end, lists:seq(0, N - 1)),
    {Parent, Rank}.

find(A, Parent) ->
    case lists:nth(A + 1, Parent) of
        X when X == A -> A;
        X -> find(X, Parent)
    end.

union(A, B, Parent, Rank) ->
    RootA = find(A, Parent),
    RootB = find(B, Parent),
    if
        RootA =:= RootB -> {false, Parent, Rank};
        Rank1 = lists:nth(RootA + 1, Rank),
        Rank2 = lists:nth(RootB + 1, Rank) ->
            if
                Rank1 < Rank2 ->
                    {true, replace(Parent, RootA, RootB), Rank};
                Rank1 > Rank2 ->
                    {true, replace(Parent, RootB, RootA), Rank};
                true ->
                    {true, replace(replace(Parent, RootA, RootB), RootB, RootA), replace(Rank, RootB, Rank1 + 1)}
            end
    end.

replace(List, Index, Value) ->
    lists:map(fun(X, I) -> if I =:= Index -> Value; true -> X end end, List, lists:seq(0, length(List) - 1)).

check_critical(N, Edges, A, B, Weight, Index) ->
    {MST, NewWeight} = kruskal(N, lists:filter(fun({_, X, Y, I}) -> I =/= Index end, Edges)),
    NewWeight > Weight.

check_pseudo(N, Edges, A, B, Weight, Index) ->
    {MST, NewWeight} = kruskal(N, [{0, A, B, Index} | lists:filter(fun({_, X, Y, I}) -> I =/= Index end, Edges)]),
    NewWeight == Weight.