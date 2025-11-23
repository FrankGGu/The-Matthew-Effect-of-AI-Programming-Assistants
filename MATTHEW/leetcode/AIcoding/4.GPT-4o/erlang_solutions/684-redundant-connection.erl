-module(solution).
-export([find_redundant_connection/1]).

find_redundant_connection(Edges) ->
    Parent = lists:duplicate(length(Edges) + 1, 0),
    lists:foreach(fun({X, Y}) -> union(Parent, X, Y) end, Edges),
    lists:reverse(Edges).

union(Parent, X, Y) ->
    RootX = find(Parent, X),
    RootY = find(Parent, Y),
    if
        RootX =:= RootY -> ok;
        true -> 
            Parent1 = lists:replace(Parent, X, RootY),
            Parent1
    end.

find(Parent, X) ->
    case lists:nth(X, Parent) of
        0 -> X;
        P -> find(Parent, P)
    end.