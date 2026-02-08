-module(solution).
-export([count_partitions/1]).

count_partitions(N) ->
    K = N div 2,
    count_partitions_helper(K, N rem 2).

count_partitions_helper(0, _) -> 1;
count_partitions_helper(K, 1) -> 0;
count_partitions_helper(K, E) -> 
    count_partitions_helper(K - 1, E + 1) + count_partitions_helper(K, E - 1).