-spec max_size_slices(Slices :: [integer()]) -> integer().
max_size_slices(Slices) ->
    N = length(Slices) div 3,
    Len = length(Slices),
    DP1 = lists:duplicate(N + 1, 0),
    DP2 = lists:duplicate(N + 1, 0),
    DP3 = lists:duplicate(N + 1, 0),
    DP4 = lists:duplicate(N + 1, 0),
    {DP1, _} = lists:foldl(fun(_, {DP, Prev}) ->
        NewDP = lists:duplicate(N + 1, 0),
        {NewDP, DP}
    end, {DP1, DP2}, lists:seq(1, Len - 1)),
    {DP3, _} = lists:foldl(fun(_, {DP, Prev}) ->
        NewDP = lists:duplicate(N + 1, 0),
        {NewDP, DP}
    end, {DP3, DP4}, lists:seq(1, Len - 1)),
    {Res1, _} = lists:foldl(fun(I, {DP, Prev}) ->
        NewDP = lists:map(fun(K) ->
            if
                K == 0 -> 0;
                true -> max(lists:nth(K, Prev), lists:nth(I, Slices) + (if I >= 2 -> lists:nth(K - 1, lists:nth(I - 1, Prev)); true -> 0 end))
            end
        end, lists:seq(0, N)),
        {NewDP, DP}
    end, {DP1, DP2}, lists:seq(1, Len - 1)),
    {Res2, _} = lists:foldl(fun(I, {DP, Prev}) ->
        NewDP = lists:map(fun(K) ->
            if
                K == 0 -> 0;
                true -> max(lists:nth(K, Prev), lists:nth(I + 1, Slices) + (if I >= 2 -> lists:nth(K - 1, lists:nth(I - 1, Prev)); true -> 0 end))
            end
        end, lists:seq(0, N)),
        {NewDP, DP}
    end, {DP3, DP4}, lists:seq(1, Len - 2)),
    max(lists:nth(N, Res1), lists:nth(N, Res2)).