-module(solution).
-export([equations_possible/1]).

equations_possible(Equations) ->
    Parent = maps:new(),
    {Parent1, _} = lists:foldl(fun([X, $=, $=, Y], {P, _}) -> union(X, Y, P) end, {Parent, 0}, Equations),
    lists:all(fun([X, $!, $=, Y]) -> find(X, Parent1) =/= find(Y, Parent1); (_) -> true end, Equations).

find(X, Parent) ->
    case maps:find(X, Parent) of
        {ok, X} -> X;
        {ok, P} -> 
            Root = find(P, Parent),
            maps:put(X, Root, Parent),
            Root;
        error -> 
            maps:put(X, X, Parent),
            X
    end.

union(X, Y, Parent) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if 
        RootX =/= RootY -> {maps:put(RootX, RootY, Parent), 0};
        true -> {Parent, 0}
    end.