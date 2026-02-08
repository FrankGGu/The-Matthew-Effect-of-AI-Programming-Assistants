-module(max_min_subsequence).
-export([maxSumOfSubsequence/2]).

maxSumOfSubsequence(Nums, K) ->
    max_sum(Nums, K).

max_sum([], _) -> 0;
max_sum([H|T], K) when K > 0 ->
    Max = H + max_sum(T, K-1),
    Other = max_sum(T, K),
    if
        Max > Other -> Max;
        true -> Other
    end;
max_sum(_, _) -> 0.