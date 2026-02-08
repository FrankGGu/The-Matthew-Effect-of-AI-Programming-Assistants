-module(target_sum).
-export([find_target_sum_ways/2]).

find_target_sum_ways(Nums, Target) ->
    find_target_sum_ways(Nums, Target, 0, 0).

find_target_sum_ways([], Target, CurrentSum, Acc) ->
    if CurrentSum =:= Target then
        Acc + 1
    else
        Acc
    end;
find_target_sum_ways([H|T], Target, CurrentSum, Acc) ->
    Acc1 = find_target_sum_ways(T, Target, CurrentSum + H, Acc),
    find_target_sum_ways(T, Target, CurrentSum - H, Acc1).