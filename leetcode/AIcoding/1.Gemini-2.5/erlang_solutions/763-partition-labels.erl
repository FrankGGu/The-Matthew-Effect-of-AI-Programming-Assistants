-module(solution).
-export([partition_labels/1]).

partition_labels(S) ->
    LastMap = build_last_map(S, 0, #{}),
    partition_labels_helper(S, 0, 0, 0, LastMap, []).

build_last_map([], _Index, Acc) ->
    Acc;
build_last_map([C | Rest], Index, Acc) ->
    build_last_map(Rest, Index + 1, maps:put(C, Index, Acc)).

partition_labels_helper([], _Index, _CurrentStart, _CurrentMaxReach, _LastMap, Acc) ->
    lists:reverse(Acc);
partition_labels_helper([C | Rest], Index, CurrentStart, CurrentMaxReach, LastMap, Acc) ->
    LastIdx = maps:get(C, LastMap),
    NewMaxReach = max(CurrentMaxReach, LastIdx),
    if
        Index == NewMaxReach ->
            PartitionLength = Index - CurrentStart + 1,
            partition_labels_helper(Rest, Index + 1, Index + 1, Index + 1, LastMap, [PartitionLength | Acc]);
        true ->
            partition_labels_helper(Rest, Index + 1, CurrentStart, NewMaxReach, LastMap, Acc)
    end.