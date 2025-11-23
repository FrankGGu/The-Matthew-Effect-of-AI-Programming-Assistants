-spec count_points(Intervals :: [[integer()]]) -> integer().
count_points(Intervals) ->
    lists:foldl(
        fun([Start, End], Acc) ->
            sets:union(Acc, sets:from_list(lists:seq(Start, End)))
        end,
        sets:new(),
        Intervals
    ),
    sets:size(
        lists:foldl(
            fun([Start, End], Acc) ->
                sets:union(Acc, sets:from_list(lists:seq(Start, End)))
            end,
            sets:new(),
            Intervals
        )
    ).