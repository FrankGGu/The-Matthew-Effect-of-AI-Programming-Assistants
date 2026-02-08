-module(solution).
-export([are_connected/3]).

-spec are_connected(N :: integer(), Threshold :: integer(), Queries :: [[integer()]]) -> [boolean()].
are_connected(N, Threshold, Queries) ->
    Parent = lists:seq(0, N),
    lists:foreach(fun(I) ->
        lists:foreach(fun(J) ->
            if 
                I > Threshold, J > Threshold, gcd(I, J) > Threshold ->
                    Union(I, J, Parent);
                true ->
                    ok
            end
        end, lists:seq(1, N))
    end, lists:seq(1, N)),
    lists:map(fun([A, B]) -> Find(A, Parent) =:= Find(B, Parent) end, Queries).

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

find(X, Parent) ->
    if
        Parent[X] =:= X -> X;
        true -> 
            PX = find(Parent[X], Parent),
            Parent[X] := PX,
            PX
    end.

union(X, Y, Parent) ->
    PX = find(X, Parent),
    PY = find(Y, Parent),
    if 
        PX =/= PY ->
            Parent[PY] := PX;
        true ->
            ok
    end.