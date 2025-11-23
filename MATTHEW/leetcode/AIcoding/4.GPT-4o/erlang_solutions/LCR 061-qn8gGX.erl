-module(solution).
-export([k_smallest_pairs/3]).

k_smallest_pairs(Xs, Ys, K) ->
    Pairs = lists:flatmap(fun(X) -> lists:map(fun(Y) -> {X, Y} end, Ys) end, Xs),
    SortedPairs = lists:sort(fun({X1, Y1}, {X2, Y2}) -> X1 + Y1 < X2 + Y2 end, Pairs),
    lists:sublist(SortedPairs, min(K, length(SortedPairs))).

min(A, B) when A < B -> A;
min(_, B) -> B.