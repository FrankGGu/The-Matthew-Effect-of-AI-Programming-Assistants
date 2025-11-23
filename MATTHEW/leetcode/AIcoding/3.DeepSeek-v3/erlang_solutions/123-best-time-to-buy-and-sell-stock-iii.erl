-spec max_profit(Prices :: [integer()]) -> integer().
max_profit(Prices) ->
    N = length(Prices),
    if 
        N =< 1 -> 0;
        true ->
            K = 2,
            Dp = array:new([{size, K + 1}, {default, array:new([{size, N}, {default, 0}])}]),
            lists:foldl(fun(Ki, _) ->
                Max = -lists:nth(1, Prices),
                lists:foldl(fun(I, _) ->
                    Old = array:get(I, array:get(Ki - 1, Dp)),
                    Current = array:get(I - 1, array:get(Ki, Dp)),
                    Max1 = max(Max, Current - lists:nth(I, Prices)),
                    Value = max(Old, Max1 + lists:nth(I, Prices)),
                    Dp1 = array:set(I, Value, array:get(Ki, Dp)),
                    Dp2 = array:set(Ki, Dp1, Dp),
                    Dp2
                end, Dp, lists:seq(2, N))
            end, Dp, lists:seq(1, K)),
            array:get(N - 1, array:get(K, Dp))
    end.