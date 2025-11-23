-module(solution).
-export([path_exists/3]).

path_exists(N, Edges, Queries) ->
    Parent = lists:seq(0, N - 1),
    lists:map(fun({U, V}) -> find(Parent, U) =:= find(Parent, V) end, Queries).

find(Parent, X) ->
    case lists:nth(X + 1, Parent) of
        X -> X;
        P -> 
            NewParent = setelement(X + 1, Parent, find(Parent, P)),
            find(NewParent, P)
    end.

union(Parent, X, Y) ->
    XRoot = find(Parent, X),
    YRoot = find(Parent, Y),
    if
        XRoot =/= YRoot -> setelement(XRoot + 1, Parent, YRoot);
        true -> Parent
    end.