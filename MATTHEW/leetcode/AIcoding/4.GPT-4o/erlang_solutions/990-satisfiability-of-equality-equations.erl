-module(solution).
-export([equationsPossible/1]).

equationsPossible(Equations) ->
    UnionFind = lists:foldl(fun(Eq, UF) -> 
        case Eq of 
            [A, '=', B] -> union(A, B, UF);
            _ -> UF
        end 
    end, init_uf(), Equations),
    lists:all(fun(Eq) -> 
        case Eq of
            [A, '=', B] -> find(A, UnionFind) == find(B, UnionFind);
            [A, '!', B] -> find(A, UnionFind) =/= find(B, UnionFind);
            _ -> true
        end
    end, Equations).

init_uf() ->
    lists:map(fun(X) -> {X, X} end, lists:seq(?A, ?Z)).

find(X, UF) ->
    case lists:keyfind(X, 1, UF) of
        {_, P} -> 
            case P == X of
                true -> X;
                false -> find(P, UF)
            end;
        false -> X
    end.

union(X, Y, UF) ->
    RootX = find(X, UF),
    RootY = find(Y, UF),
    if
        RootX =:= RootY -> UF;
        true -> lists:map(fun({K, V}) -> 
            if V == RootX -> {K, RootY}; true -> {K, V} end 
        end, UF)
    end.