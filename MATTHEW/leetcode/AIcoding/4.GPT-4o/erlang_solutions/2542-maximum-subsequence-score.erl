-module(solution).
-export([max_subsequence_score/3]).

max_subsequence_score(A, B, K) ->
    {N, _} = lists:foldl(fun(X, {N, Acc}) -> {N + 1, [X | Acc]} end, {0, []}, A),
    Pairs = lists:zip(A, B),
    SortedPairs = lists:sort(fun({_, B1}, {_, B2}) -> B1 > B2 end, Pairs),
    TopK = lists:sublist(SortedPairs, K),
    Score = lists:sum(lists:map(fun({A1, _}) -> A1 end, TopK)),
    SumB = lists:sum(lists:map(fun({_, B1}) -> B1 end, TopK)),
    {Score, SumB}.