-spec min_cost(N :: integer(), Cuts :: [integer()]) -> integer().
min_cost(N, Cuts) ->
    Sorted = lists:sort([0 | Cuts] ++ [N]),
    Len = length(Sorted),
    DP = array:new([{size, Len}, {default, array:new([{size, Len}, {default, 0}])}]),
    {_, Res} = solve(1, Len - 2, Sorted, DP),
    Res.

solve(I, J, Sorted, DP) ->
    case I > J of
        true -> {DP, 0};
        false ->
            case array:get(I, array:get(J, DP)) of
                0 ->
                    MinCost = lists:min(
                        lists:map(
                            fun(K) ->
                                {DP1, Left} = solve(I, K - 1, Sorted, DP),
                                {DP2, Right} = solve(K + 1, J, Sorted, DP1),
                                Cost = Left + Right + (lists:nth(J + 1, Sorted) - lists:nth(I - 1, Sorted)),
                                {DP2, Cost}
                            end,
                            lists:seq(I, J)
                        )
                    ),
                    {DP3, Cost} = MinCost,
                    NewRow = array:set(J, Cost, array:get(I, DP3)),
                    NewDP = array:set(I, NewRow, DP3),
                    {NewDP, Cost};
                Cached -> {DP, Cached}
            end
    end.