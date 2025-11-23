-spec count_of_pairs(n :: integer(), x :: integer(), y :: integer()) -> [integer()].
count_of_pairs(N, X, Y) ->
    Dist = lists:duplicate(N, 0),
    {X1, Y1} = if X < Y -> {X, Y}; true -> {Y, X} end,
    lists:foldl(fun(K, Acc) ->
        lists:foldl(fun(I, D) ->
            J = I + K,
            if J > N -> D;
               true ->
                MinDist = min(J - I, abs(I - X1) + 1 + abs(J - Y1)),
                D1 = lists:sublist(D, MinDist - 1) ++ [lists:nth(MinDist, D) + 1] ++ lists:nthtail(MinDist, D),
                D1
            end
        end, Acc, lists:seq(1, N))
    end, Dist, lists:seq(1, N - 1)).