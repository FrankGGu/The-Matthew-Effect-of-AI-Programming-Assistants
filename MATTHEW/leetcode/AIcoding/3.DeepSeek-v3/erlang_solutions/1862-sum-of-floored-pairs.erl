-spec sum_of_floored_pairs(Nums :: [integer()]) -> integer().
sum_of_floored_pairs(Nums) ->
    Max = lists:max(Nums),
    Freq = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(V) -> V + 1 end, 1, Acc) end, #{}, Nums),
    Prefix = lists:foldl(fun(X, {Sum, Acc}) -> 
        NewSum = Sum + maps:get(X, Freq, 0),
        {NewSum, Acc#{X => NewSum}}
    end, {0, #{}}, lists:seq(0, Max)),
    PrefixSum = element(2, Prefix),

    lists:foldl(fun(X, Sum) ->
        F = maps:get(X, Freq, 0),
        if 
            F == 0 -> Sum;
            true ->
                Multiplier = 1,
                Total = lists:foldl(fun(D, Acc) ->
                    Lower = X * D,
                    Upper = X * (D + 1) - 1,
                    if 
                        Lower > Max -> Acc;
                        true ->
                            Upper1 = min(Upper, Max),
                            Count = maps:get(Upper1, PrefixSum, 0) - maps:get(Lower - 1, PrefixSum, 0),
                            Acc + D * Count * F
                    end
                end, 0, lists:seq(1, Max div X + 1)),
                Sum + Total
        end
    end, 0, lists:seq(1, Max)) rem 1000000007.