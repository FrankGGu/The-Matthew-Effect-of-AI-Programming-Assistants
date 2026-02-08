-spec min_repair_time(Ranks :: [integer()], Cars :: integer()) -> integer().
min_repair_time(Ranks, Cars) ->
    MaxRank = lists:max(Ranks),
    Left = 1,
    Right = MaxRank * Cars * Cars,
    binary_search(Ranks, Cars, Left, Right).

binary_search(Ranks, Cars, Left, Right) ->
    if
        Left >= Right -> Left;
        true ->
            Mid = (Left + Right) div 2,
            case can_repair(Ranks, Cars, Mid) of
                true -> binary_search(Ranks, Cars, Left, Mid);
                false -> binary_search(Ranks, Cars, Mid + 1, Right)
            end
    end.

can_repair(Ranks, Cars, Time) ->
    Total = lists:foldl(fun(Rank, Acc) ->
        Acc + trunc(math:sqrt(Time div Rank))
    end, 0, Ranks),
    Total >= Cars.