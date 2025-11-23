-module(minimum_cost_cutting_cake_ii).
-export([min_cost/2]).

min_cost(cut, cakeLength) ->
    Len = length(cut),
    Cut = lists:sort(cut),
    Cut1 = [0 | Cut],
    Cut2 = Cut1 ++ [cakeLength],
    DP = array:new({0,Len+1},{0,Len+1}),
    fill_dp(DP, Cut2, 1, Len).

fill_dp(DP, Cut2, L, R) when L > R ->
    0;
fill_dp(DP, Cut2, L, R) ->
    Cost = array:get({L, R}, DP),
    case Cost of
        undefined ->
            MinCost = find_min_cost(DP, Cut2, L, R),
            array:set({L, R}, MinCost, DP),
            MinCost;
        _ ->
            Cost
    end.

find_min_cost(DP, Cut2, L, R) ->
    Len = Cut2[R+1+1] - Cut2[L],
    lists:foldl(fun(K, Acc) ->
                        Left = fill_dp(DP, Cut2, L, K-1),
                        Right = fill_dp(DP, Cut2, K+1, R),
                        min(Acc, Left + Right + Len)
                end,
                infinity,
                lists:seq(L, R)).