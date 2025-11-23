-module(solution).
-export([optimal_partition/1]).

optimal_partition(S) ->
    if S == [] -> 0;
    else -> optimal_partition_loop(S, gb_sets:new(), 1)
    end.

optimal_partition_loop([], _CurrentSet, PartitionCount) ->
    PartitionCount;
optimal_partition_loop([H|T], CurrentSet, PartitionCount) ->
    if gb_sets:is_member(H, CurrentSet) ->
        optimal_partition_loop(T, gb_sets:add(H, gb_sets:new()), PartitionCount + 1);
    else ->
        optimal_partition_loop(T, gb_sets:add(H, CurrentSet), PartitionCount)
    end.