-module(solution).
-export([maximum_total_reward/3]).

maximum_total_reward(N, operations, rewards) ->
    maximum_total_reward_helper(N, operations, rewards, 0).

maximum_total_reward_helper(_, [], _, Acc) ->
    Acc;
maximum_total_reward_helper(N, [{Op, X} | Ops], Rewards, Acc) ->
    case Op of
        1 -> 
            maximum_total_reward_helper(N, Ops, Rewards, Acc + lists:nth(X + 1, Rewards));
        2 -> 
            maximum_total_reward_helper(N, Ops, Rewards, Acc - lists:nth(X + 1, Rewards));
        _ -> 
            maximum_total_reward_helper(N, Ops, Rewards, Acc)
    end.