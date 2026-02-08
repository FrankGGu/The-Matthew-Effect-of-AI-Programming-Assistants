-module(solution).
-export([countKSubsequences/2]).

countKSubsequences(S, K) ->
    MaxBeauty = max_beauty(S),
    case MaxBeauty of
        0 -> 0;
        _ -> count_subsequences(S, K, MaxBeauty)
    end.

max_beauty(S) ->
    lists:max(lists:map(fun(X) -> lists:count(X, X) end, lists:uniq(S))).

count_subsequences(S, K, MaxBeauty) ->
    Count = lists:foldl(fun(X, Acc) -> Acc + lists:count(X, MaxBeauty) end, 0, lists:uniq(S)),
    if
        Count < K -> 0;
        true -> combinatorial(Count, K)
    end.

combinatorial(N, R) ->
    if
        N < R -> 0;
        R == 0 -> 1;
        true -> factorial(N) div (factorial(R) * factorial(N - R))
    end.

factorial(N) ->
    lists:foldl(fun(X, Acc) -> X * Acc end, 1, lists:seq(1, N)).