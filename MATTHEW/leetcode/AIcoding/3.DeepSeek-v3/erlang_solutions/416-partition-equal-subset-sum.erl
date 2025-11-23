-spec can_partition(Nums :: [integer()]) -> boolean().
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
    NewDP = sets:fold(fun(Sum, Acc) -> 
        case Sum + Num of
            S when S =< Target -> sets:add_element(S, Acc);
            _ -> Acc
        end
    end, DP, DP),
    case sets:is_element(Target, NewDP) of
        true -> true;
        false -> can_partition_helper(Rest, Target, NewDP)
    end.