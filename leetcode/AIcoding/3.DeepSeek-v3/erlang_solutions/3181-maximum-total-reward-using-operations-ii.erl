-module(solution).
-export([max_total_reward/1]).

max_total_reward(Rewards) ->
    lists:max([0 | lists:foldl(fun(R, Acc) -> 
        sets:to_list(sets:union(sets:from_list([R | [X + R || X <- Acc, X < R]]), sets:from_list(Acc)))
    end, [], lists:sort(Rewards))]).