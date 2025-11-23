-module(solution).
-export([can_partition/1]).

can_partition(Nums) ->
    Sum = lists:sum(Nums),
    case Sum rem 2 of
        0 ->
            Target = Sum div 2,
            DP = sets:from_list([0]),
            can_partition_helper(Nums, Target, DP);
        1 ->
            false
    end.

can_partition_helper([], Target, DP) ->
    sets:is_element(Target, DP);
can_partition_helper([Num | Rest], Target, DP) ->
    NewDP = sets:fold(fun(Sum, Acc) ->
        case Sum + Num of
            NewSum when NewSum =< Target ->
                sets:add_element(NewSum, Acc);
            _ ->
                Acc
        end
    end, DP, DP),
    can_partition_helper(Rest, Target, sets:union(DP, NewDP)).