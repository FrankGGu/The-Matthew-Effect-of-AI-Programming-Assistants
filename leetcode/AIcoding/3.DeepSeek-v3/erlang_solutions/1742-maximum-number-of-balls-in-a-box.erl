-spec count_balls(LowLimit :: integer(), HighLimit :: integer()) -> integer().
count_balls(LowLimit, HighLimit) ->
    Counts = lists:foldl(
        fun(N, Acc) ->
            Sum = lists:foldl(
                fun(D, S) -> S + D - $0 end,
                0,
                integer_to_list(N)
            ),
            maps:update_with(Sum, fun(V) -> V + 1 end, 1, Acc)
        end,
        maps:new(),
        lists:seq(LowLimit, HighLimit)
    ),
    case maps:size(Counts) of
        0 -> 0;
        _ -> lists:max(maps:values(Counts))
    end.