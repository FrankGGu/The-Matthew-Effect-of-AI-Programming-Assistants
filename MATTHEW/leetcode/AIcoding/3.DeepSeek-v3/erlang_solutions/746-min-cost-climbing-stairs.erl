-spec min_cost_climbing_stairs(Cost :: [integer()]) -> integer().
min_cost_climbing_stairs(Cost) ->
    N = length(Cost),
    DP = lists:duplicate(N + 1, 0),
    {_, Result} = lists:foldl(fun(I, {PrevDP, _}) ->
        CurrentCost = case I < 1 of
            true -> 0;
            false -> lists:nth(I, Cost)
        end,
        Prev1 = lists:nth(I, PrevDP),
        Prev2 = lists:nth(I + 1, PrevDP),
        NewVal = CurrentCost + min(Prev1, Prev2),
        NewDP = setelement(I + 2, PrevDP, NewVal),
        {NewDP, NewVal}
    end, {DP, 0}, lists:seq(0, N - 1)),
    min(lists:nth(N, DP), lists:nth(N + 1, DP)).