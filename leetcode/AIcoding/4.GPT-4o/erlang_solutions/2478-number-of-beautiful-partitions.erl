-module(solution).
-export([count_beautiful_partitions/2]).

count_beautiful_partitions(N, K) ->
    M = length(N),
    Max = trunc(math:log2(M)) + 1,
    DP = lists:duplicate(Max + 1, lists:duplicate(K + 1, 0)),
    DP = lists:flatten([DP]),
    DP = lists:map(fun(X) -> X end, DP),
    DP = lists:nth(1, DP),
    DP = lists:map(fun(X) -> lists:duplicate(K + 1, 0) end, lists:seq(1, Max)),
    count_beautiful_partitions_helper(N, 1, K, DP).

count_beautiful_partitions_helper(N, I, K, DP) when I > length(N) -> 
    lists:nth(K + 1, lists:nth(I, DP));
count_beautiful_partitions_helper(N, I, K, DP) -> 
    count_beautiful_partitions_helper(N, I + 1, K, DP).