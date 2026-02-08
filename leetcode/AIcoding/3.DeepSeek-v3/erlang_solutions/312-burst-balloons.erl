-spec max_coins(Nums :: [integer()]) -> integer().
max_coins(Nums) ->
    NewNums = [1] ++ Nums ++ [1],
    N = length(NewNums),
    DP = array:new([{size, N}, {default, array:new([{size, N}, {default, 0}])}]),
    solve(NewNums, 1, N - 2, DP).

solve(Nums, Left, Right, DP) ->
    case Left > Right of
        true -> 0;
        false ->
            case array:get(Right, array:get(Left, DP)) of
                0 ->
                    Max = lists:max(
                            lists:map(
                                fun(K) ->
                                    array:get(Left - 1, Nums) * array:get(K, Nums) * array:get(Right + 1, Nums) +
                                    solve(Nums, Left, K - 1, DP) +
                                    solve(Nums, K + 1, Right, DP)
                                end,
                                lists:seq(Left, Right))),
                    NewDP = array:set(Left, array:set(Right, Max, array:get(Left, DP)), DP),
                    Max;
                Cached -> Cached
            end
    end.