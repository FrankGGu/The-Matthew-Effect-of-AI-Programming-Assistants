-module(satisfiability_of_equality_equations).
-export([equations_possible/1]).

equations_possible(Equations) ->
    Parent = array:new(26, {fixed, 0}),
    lists:foreach(
        fun(Equation) ->
            [A,Op,B] = string:tokens(Equation, "!=="),
            if
                Op == "=" ->
                    Union = union(list_to_integer(A), list_to_integer(B), Parent);
                true ->
                    ok
            end
        end,
        Equations
    ),

    lists:all(
        fun(Equation) ->
            [A,Op,B] = string:tokens(Equation, "!=="),
            if
                Op == "!" ->
                    find(list_to_integer(A), Parent) /= find(list_to_integer(B), Parent);
                true ->
                    true
            end
        end,
        Equations
    ).

list_to_integer([C]) ->
    C - $a.

find(X, Parent) ->
    case array:get(X, Parent) of
        0 ->
            X;
        P ->
            R = find(P, Parent),
            array:set(X, R, Parent),
            R
    end.

union(X, Y, Parent) ->
    RootX = find(X, Parent),
    RootY = find(Y, Parent),
    if
        RootX /= RootY ->
            array:set(RootX, RootY, Parent);
        true ->
            ok
    end.