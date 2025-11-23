-module(solution).
-export([findRedundantConnection/1]).

findRedundantConnection(Edges) ->
    N = length(Edges),
    Parent = lists:seq(0, N),
    findRedundant(Edges, Parent).

findRedundant([], _) -> [];
findRedundant([[U, V] | T], Parent) ->
    case find(U, Parent) == find(V, Parent) of
        true -> [U, V];
        false ->
            NewParent = union(U, V, Parent),
            findRedundant(T, NewParent)
    end.

find(X, Parent) ->
    case lists:nth(X + 1, Parent) of
        X -> X;
        P -> find(P, Parent)
    end.

union(U, V, Parent) ->
    RootU = find(U, Parent),
    RootV = find(V, Parent),
    setelement(RootV + 1, Parent, RootU).