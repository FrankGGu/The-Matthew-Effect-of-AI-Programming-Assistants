-module(max_total_reward).
-export([maximumTotalReward/1]).

maximumTotalReward(Reward) ->
    lists:foldl(fun(X, Acc) -> 
        case lists:member(X, Acc) of
            true -> Acc;
            false -> [X | Acc]
        end
    end, [], Reward).

maximumTotalReward(Nums, Acc, Max) when Num < Max ->
    lists:foldl(fun(X, Acc2) -> 
        case lists:member(X, Acc2) of
            true -> Acc2;
            false -> [X | Acc2]
        end
    end, Acc, Nums).

maximumTotalReward(Nums, Acc, Max) ->
    Acc.