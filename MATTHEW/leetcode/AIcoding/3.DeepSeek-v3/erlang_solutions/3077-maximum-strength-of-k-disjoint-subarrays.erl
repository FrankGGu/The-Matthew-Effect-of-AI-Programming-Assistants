-spec max_strength(Nums :: [integer()], K :: integer()) -> integer().
max_strength(Nums, K) ->
    N = length(Nums),
    if
        K =:= 0 -> 0;
        true ->
            {DP, _} = lists:foldl(fun(_, {Acc, _}) -> {Acc, Acc} end, {lists:duplicate(N + 1, 0), lists:duplicate(N + 1, 0)}, lists:seq(1, K)),
            lists:foldl(fun(I, {DP, LastDP}) ->
                Max = lists:foldl(fun(J, {MaxVal, Curr}) ->
                    Sum = lists:sum(lists:sublist(Nums, J, I - J + 1)),
                    NewCurr = max(Sum, Sum + lists:nth(J, LastDP)),
                    {max(MaxVal, NewCurr), NewCurr}
                end, {-1000000000, -1000000000}, lists:seq(1, I)),
                NewDP = lists:sublist(DP, I) ++ [element(1, Max)],
                {NewDP, DP}
            end, {DP, lists:duplicate(N + 1, 0)}, lists:seq(1, N)),
            lists:nth(N, element(1, lists:last(lists:foldl(fun(_, {DP, LastDP}) ->
                Max = lists:foldl(fun(J, {MaxVal, Curr}) ->
                    Sum = lists:sum(lists:sublist(Nums, J, N - J + 1)),
                    NewCurr = max(Sum, Sum + lists:nth(J, LastDP)),
                    {max(MaxVal, NewCurr), NewCurr}
                end, {-1000000000, -1000000000}, lists:seq(1, N)),
                NewDP = lists:sublist(DP, N) ++ [element(1, Max)],
                {NewDP, DP}
            end, {DP, lists:duplicate(N + 1, 0)}, lists:seq(1, K))))
    end.