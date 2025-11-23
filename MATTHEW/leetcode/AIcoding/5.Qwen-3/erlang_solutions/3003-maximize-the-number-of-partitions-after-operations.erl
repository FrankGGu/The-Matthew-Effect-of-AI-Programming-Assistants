-module(maximize_partitions_after_operations).
-export([max_partitions/1]).

max_partitions(S) ->
    max_partitions(S, 0, 0, 0).

max_partitions([], _, _, Acc) ->
    Acc;
max_partitions([C | T], Index, Last, Acc) ->
    if
        C == $a andalso Index >= Last ->
            max_partitions(T, Index + 1, Index, Acc + 1);
        true ->
            max_partitions(T, Index + 1, Last, Acc)
    end.