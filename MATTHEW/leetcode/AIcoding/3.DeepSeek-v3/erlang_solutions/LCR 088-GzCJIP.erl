-spec min_cost_climbing_stairs(Cost :: [integer()]) -> integer().
min_cost_climbing_stairs(Cost) ->
    N = length(Cost),
    DP = lists:duplicate(N + 1, 0),
    {DP1, _} = lists:foldl(fun(I, {Dp, _}) ->
        case I of
            0 -> {Dp, 0};
            1 -> {Dp, 0};
            _ ->
                V1 = lists:nth(I - 1, Dp) + lists:nth(I - 1, Cost),
                V2 = lists:nth(I - 2, Dp) + lists:nth(I - 2, Cost),
                NewVal = min(V1, V2),
                NewDp = setelement(I, Dp, NewVal),
                {NewDp, NewVal}
        end
    end, {list_to_tuple(DP), 0}, lists:seq(2, N + 1)),
    element(N + 1, DP1).