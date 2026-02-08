-module(solution).
-export([permutation_query/2]).

permutation_query(P, Q) ->
    N = length(P),
    Keyed = lists:zip(P, lists:seq(1, N)),
    Sorted = lists:sort(fun({A, _}, {B, _}) -> A < B end, Keyed),
    lists:map(fun({_, Index}) -> Index end, Sorted),
    lists:map(fun(X) -> lists:nth(X, P) end, Q).