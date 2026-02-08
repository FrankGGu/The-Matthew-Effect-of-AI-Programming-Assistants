-spec super_egg_drop(K :: integer(), N :: integer()) -> integer().
super_egg_drop(K, N) ->
    Mem = maps:new(),
    {Res, _} = dp(K, N, Mem),
    Res.

dp(1, N, Mem) -> {N, Mem};
dp(K, 1, Mem) -> {1, Mem};
dp(K, N, Mem) ->
    case maps:find({K, N}, Mem) of
        {ok, Val} -> {Val, Mem};
        error ->
            Low = 1,
            High = N,
            {Ans, NewMem} = binary_search(K, N, Low, High, Mem),
            {Ans, maps:put({K, N}, Ans, NewMem)}
    end.

binary_search(K, N, Low, High, Mem) ->
    if
        Low > High ->
            {Low, Mem};
        true ->
            Mid = (Low + High) div 2,
            {Left, Mem1} = dp(K - 1, Mid - 1, Mem),
            {Right, Mem2} = dp(K, N - Mid, Mem1),
            if
                Left < Right ->
                    binary_search(K, N, Mid + 1, High, Mem2);
                Left > Right ->
                    binary_search(K, N, Low, Mid - 1, Mem2);
                true ->
                    {Left + 1, Mem2}
            end
    end.