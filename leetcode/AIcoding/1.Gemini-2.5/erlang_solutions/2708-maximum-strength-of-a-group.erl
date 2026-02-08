-module(solution).
-export([max_strength/1]).

max_strength(Nums) ->
    AllSubsequences = subsequences_non_empty(Nums),
    Products = [lists:foldl(fun(X, Acc) -> X * Acc end, 1, Subseq) || Subseq <- AllSubsequences],
    lists:max(Products).

subsequences([]) -> [[]];
subsequences([H|T]) ->
    RestSubsequences = subsequences(T),
    RestSubsequences ++ [[H|S] || S <- RestSubsequences].

subsequences_non_empty(L) ->
    lists:delete([], subsequences(L)).