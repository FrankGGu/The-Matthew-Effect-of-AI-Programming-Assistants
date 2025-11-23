-spec number_of_ways(S :: unicode:unicode_binary()) -> integer().
number_of_ways(S) ->
    Bin = binary_to_list(S),
    {Count0, Count1} = lists:foldl(fun
        ($0, {C0, C1}) -> {C0 + 1, C1};
        ($1, {C0, C1}) -> {C0, C1 + 1};
        (_, Acc) -> Acc
    end, {0, 0}, Bin),
    {Res, _, _} = lists:foldl(fun
        ($0, {R, C1, C01}) -> {R + C01, C1, C01};
        ($1, {R, C1, C01}) -> {R + C1, C1 + 1, C01 + C1};
        (_, Acc) -> Acc
    end, {0, 0, 0}, Bin),
    Res.