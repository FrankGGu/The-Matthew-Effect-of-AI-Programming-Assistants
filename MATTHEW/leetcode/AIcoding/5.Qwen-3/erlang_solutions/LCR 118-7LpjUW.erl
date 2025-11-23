-module(redundant_connection).
-export([find_redundant_connection/1]).

find_redundant_connection(Edges) ->
    Parent = lists:seq(1, length(Edges) + 1),
    lists:foldl(fun({A, B}, Acc) ->
        case find(A, Parent) of
            X when X == find(B, Parent) -> {A, B};
            _ -> union(A, B, Parent)
        end
    end, undefined, Edges).

find(X, Parent) ->
    if
        X =:= lists:nth(X, Parent) -> X;
        true -> find(lists:nth(X, Parent), Parent)
    end.

union(X, Y, Parent) ->
    PX = find(X, Parent),
    PY = find(Y, Parent),
    if
        PX =/= PY -> lists:sublist(Parent, PX, 1) ++ [PY] ++ lists:sublist(Parent, PX + 1);
        true -> Parent
    end.