-module(partition_array_into_disjoint_intervals).
-export([partition_disjoint_integers/1]).

partition_disjoint_integers(A) ->
    N = length(A),
    MaxSoFar = lists:foldl(fun(X, Acc) -> max(X, Acc) end, hd(A), tl(A)),
    PartitionPoint = 0,
    partition_disjoint_integers(A, 0, MaxSoFar, 0).

partition_disjoint_integers([], _Idx, _MaxSoFar, _PartitionPoint) ->
    PartitionPoint;
partition_disjoint_integers([H|T], Idx, MaxSoFar, PartitionPoint) ->
    if
        H > MaxSoFar ->
            partition_disjoint_integers(T, Idx + 1, H, Idx);
        true ->
            partition_disjoint_integers(T, Idx + 1, MaxSoFar, PartitionPoint)
    end.