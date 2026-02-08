-module(solution).
-export([make_connected/2]).

make_connected(N, Connections) ->
    case length(Connections) < N - 1 of
        true -> -1;
        false ->
            Parent = lists:seq(0, N - 1),
            UnionFind = union_find(Connections, Parent),
            Sets = sets:from_list([find(X, UnionFind) || X <- lists:seq(0, N - 1)]),
            sets:size(Sets) - 1
    end.

union_find([], Parent) -> Parent;
union_find([[A, B] | Rest], Parent) ->
    RootA = find(A, Parent),
    RootB = find(B, Parent),
    case RootA =:= RootB of
        true -> union_find(Rest, Parent);
        false -> union_find(Rest, setelement(RootB + 1, Parent, RootA))
    end.

find(X, Parent) ->
    case element(X + 1, Parent) of
        X -> X;
        P -> find(P, Parent)
    end.