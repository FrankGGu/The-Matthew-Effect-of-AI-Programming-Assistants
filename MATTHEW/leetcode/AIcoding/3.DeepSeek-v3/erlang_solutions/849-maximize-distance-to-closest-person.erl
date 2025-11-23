-spec max_dist_to_closest(Seats :: [integer()]) -> integer().
max_dist_to_closest(Seats) ->
    N = length(Seats),
    Left = lists:duplicate(N, 0),
    Right = lists:duplicate(N, 0),
    {Left1, _} = lists:foldl(fun(I, {Acc, Prev}) ->
        case lists:nth(I, Seats) of
            1 -> {lists:sublist(Acc, I - 1) ++ [0] ++ lists:nthtail(I, Acc), I};
            0 -> {lists:sublist(Acc, I - 1) ++ [I - Prev] ++ lists:nthtail(I, Acc), Prev}
        end
    end, {Left, -N}, lists:seq(1, N)),
    {Right1, _} = lists:foldr(fun(I, {Acc, Prev}) ->
        case lists:nth(I, Seats) of
            1 -> {lists:sublist(Acc, I - 1) ++ [0] ++ lists:nthtail(I, Acc), I};
            0 -> {lists:sublist(Acc, I - 1) ++ [Prev - I] ++ lists:nthtail(I, Acc), Prev}
        end
    end, {Right, 2 * N}, lists:seq(1, N)),
    lists:max(lists:map(fun({L, R}) -> min(L, R) end, lists:zip(Left1, Right1)))).