-module(solution).
-export([maximize_partitions/2]).

maximize_partitions(N, k) ->
    partitions(N, k, 0).

partitions(0, _, Count) ->
    Count;
partitions(N, k, Count) when N > 0 ->
    NewCount = Count + 1,
    partitions(N - k, k, NewCount).