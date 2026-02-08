-module(redundant_connection).
-export([find_redundant_connection/1]).

find_redundant_connection(Edges) ->
    Parent = lists:seq(1, length(Edges)),
    find_redundant_connection(Edges, Parent).

find_redundant_connection([], _) ->
    [];
find_redundant_connection([[A,B] | Rest], Parent) ->
    case find(A, Parent) == find(B, Parent) of
        true -> [A,B];
        false -> find_redundant_connection(Rest, union(A, B, Parent))
    end.

find(X, Parent) ->
    if
        X =:= lists:nth(X, Parent) -> X;
        true -> find(lists:nth(X, Parent), Parent)
    end.

union(X, Y, Parent) ->
    PX = find(X, Parent),
    PY = find(Y, Parent),
    if
        PX =/= PY -> lists:sublist(Parent, PX - 1) ++ [PY] ++ lists:sublist(Parent, PX + 1, length(Parent) - PX);
        true -> Parent
    end.