-module(solution).
-export([can_partition/1]).

can_partition(Nums) ->
    Total = lists:sum(Nums),
    case Total rem 2 of
        1 -> false;
        0 -> 
            Half = Total div 2,
            DP = sets:from_list([0]),
            can_partition_helper(Nums, Half, DP)
    end.

can_partition_helper([], Target, DP) ->
    sets:is_element(Target, DP);
can_partition_helper([Num | Rest], Target, DP) ->
    case sets:is_element(Target, DP) of
        true -> true;
        false ->
            NewDP = sets:fold(fun(E, Acc) -> 
                case E + Num =< Target of
                    true -> sets:add_element(E + Num, Acc);
                    false -> Acc
                end
            end, DP, DP),
            can_partition_helper(Rest, Target, NewDP)
    end.