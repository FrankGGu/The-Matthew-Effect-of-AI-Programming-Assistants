-spec mincost_tickets(Days :: [integer()], Costs :: [integer()]) -> integer().
mincost_tickets(Days, Costs) ->
    LastDay = lists:last(Days),
    DP = maps:from_list([{0, 0}]),
    {_, Result} = lists:foldl(fun(Day, {DPAcc, _}) ->
        case lists:member(Day, Days) of
            true ->
                Cost1 = maps:get(max(0, Day - 1), DPAcc, 0) + lists:nth(1, Costs),
                Cost7 = maps:get(max(0, Day - 7), DPAcc, 0) + lists:nth(2, Costs),
                Cost30 = maps:get(max(0, Day - 30), DPAcc, 0) + lists:nth(3, Costs),
                MinCost = min(Cost1, min(Cost7, Cost30)),
                {maps:put(Day, MinCost, DPAcc), MinCost};
            false ->
                PrevCost = maps:get(Day - 1, DPAcc, 0),
                {maps:put(Day, PrevCost, DPAcc), PrevCost}
        end
    end, {DP, 0}, lists:seq(1, LastDay)),
    Result.