-module(solution).
-export([minimize_max_edge_weight/2]).

minimize_max_edge_weight(N, Edges) ->
    Parent = lists:seq(0, N),
    SortedEdges = lists:sort(fun([A, B, W1], [_, _, W2]) -> W1 =< W2 end, Edges),
    Kruskal(SortedEdges, Parent, 0, 1).

find(Parent, X) ->
    case lists:nth(X + 1, Parent) of
        X -> X;
        PX -> 
            NewPX = find(Parent, PX),
            Parent1 = setelement(X + 1, list_to_tuple(Parent), NewPX),
            find(Parent1, X)
    end.

union(Parent, X, Y) ->
    PX = find(Parent, X),
    PY = find(Parent, Y),
    if
        PX =:= PY -> Parent;
        true -> 
            Parent1 = setelement(PX + 1, list_to_tuple(Parent), PY),
            Parent1
    end.

kruskal([], _, MaxEdge, _) -> MaxEdge;
kruskal([[U, V, W] | Rest], Parent, _, Components) when Components >= length(Parent) - 1 -> W;
kruskal([[U, V, W] | Rest], Parent, MaxEdge, Components) ->
    PU = find(Parent, U),
    PV = find(Parent, V),
    if
        PU =:= PV -> kruskal(Rest, Parent, max(MaxEdge, W), Components);
        true -> 
            NewParent = union(Parent, PU, PV),
            kruskal(Rest, NewParent, max(MaxEdge, W), Components + 1)
    end.