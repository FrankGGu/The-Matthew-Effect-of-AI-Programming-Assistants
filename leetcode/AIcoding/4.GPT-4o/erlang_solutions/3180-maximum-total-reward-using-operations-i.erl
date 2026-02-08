-module(solution).
-export([maximum_total_reward/2]).

maximum_total_reward(N, operations) ->
    lists:foldl(fun({Op, Val}, Acc) ->
        case Op of
            1 -> Acc + Val;
            2 -> Acc - Val;
            _ -> Acc
        end
    end, 0, operations).