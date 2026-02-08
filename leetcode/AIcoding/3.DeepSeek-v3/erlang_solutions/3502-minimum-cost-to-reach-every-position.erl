-spec min_cost_to_reach_every_position(Costs :: [[integer()]]) -> integer().
min_cost_to_reach_every_position(Costs) ->
    [Row | Rest] = Costs,
    MinCosts = lists:foldl(fun(Row, Acc) -> 
        lists:foldl(fun({Cost, Index}, {PrevRow, Result}) ->
            MinPrev = case Index of
                0 -> lists:nth(1, PrevRow);
                _ when Index == length(PrevRow) -> lists:nth(Index, PrevRow);
                _ -> min(lists:nth(Index, PrevRow), lists:nth(Index + 1, PrevRow))
            end,
            {PrevRow, [MinPrev + Cost | Result]}
        end, {Acc, []}, lists:zip(Row, lists:seq(1, length(Row))) end,
    Row, Rest),
    lists:min(lists:reverse(MinCosts)).