-module(solution).
-export([pivot/4]).

pivot(Data, GroupByKey, PivotKey, ValueKey) ->
    GroupedAndPivoted = lists:foldl(
        fun(RowMap, Acc) ->
            GroupValue = maps:get(GroupByKey, RowMap),
            PivotValue = maps:get(PivotKey, RowMap),
            ValueValue = maps:get(ValueKey, RowMap),
            CurrentRowMap = maps:get(GroupValue, Acc, #{}),
            UpdatedRowMap = maps:put(PivotValue, ValueValue, CurrentRowMap),
            maps:put(GroupValue, UpdatedRowMap, Acc)
        end,
        #{},
        Data
    ),
    maps:fold(
        fun(GroupValue, PivotedRowMap, Acc) ->
            NewRowMap = maps:put(GroupByKey, GroupValue, PivotedRowMap),
            [NewRowMap | Acc]
        end,
        [],
        GroupedAndPivoted
    ).