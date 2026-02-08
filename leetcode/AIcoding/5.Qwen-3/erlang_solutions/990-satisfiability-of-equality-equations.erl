-module(satisfiability_of_equality_equations).
-export([equationsPossible/1]).

equationsPossible(Expressions) ->
    Parent = maps:new(),
    lists:foreach(fun(Expr) -> 
        [A, Op, B] = string:split(Expr, "="),
        AChar = hd(A),
        BChar = hd(B),
        if
            Op == "=" ->
                if not maps:is_key(AChar, Parent) -> maps:put(AChar, AChar, Parent); true -> ok end,
                if not maps:is_key(BChar, Parent) -> maps:put(BChar, BChar, Parent); true -> ok end,
                Union(Parent, AChar, BChar);
            true ->
                ok
        end
    end, Expressions),
    lists:all(fun(Expr) ->
        [A, Op, B] = string:split(Expr, "="),
        AChar = hd(A),
        BChar = hd(B),
        if
            Op == "=" ->
                Find(Parent, AChar) == Find(Parent, BChar);
            true ->
                Find(Parent, AChar) /= Find(Parent, BChar)
        end
    end, Expressions).

Find(Parent, X) ->
    case maps:get(X, Parent) of
        X -> X;
        _ -> Find(Parent, maps:get(X, Parent))
    end.

Union(Parent, X, Y) ->
    PX = Find(Parent, X),
    PY = Find(Parent, Y),
    if
        PX /= PY -> maps:put(PX, PY, Parent);
        true -> ok
    end.