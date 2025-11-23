-module(solution).
-export([lastStoneWeightII/1]).

lastStoneWeightII(Stones) ->
    Sum = lists:sum(Stones),
    Target = Sum div 2,
    N = length(Stones),
    DP = lists:duplicate(Target + 1, false),
    DP = lists:foldl(fun(X, DP) ->
        lists:foldl(fun(K, DP) -> 
            if K >= X -> 
                lists:replace(DP, K, true); 
                true -> 
                DP 
            end 
        end, DP, lists:seq(Target, X, -1))
    end, DP, Stones),
    lists:foldl(fun(I, Acc) -> 
        if DP(I) -> 
            Acc = I 
        else 
            Acc 
        end 
    end, 0, lists:seq(Target, 0, -1)) * 2 - Sum.