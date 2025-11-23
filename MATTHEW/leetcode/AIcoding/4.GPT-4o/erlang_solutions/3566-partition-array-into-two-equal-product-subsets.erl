-module(solution).
-export([can_partition/1]).

can_partition(List) ->
    TotalProduct = lists:foldl(fun(X, Acc) -> Acc * X end, 1, List),
    if 
        TotalProduct rem 2 =:= 1 -> false;
        true -> 
            HalfProduct = TotalProduct div 2,
            can_partition_helper(List, HalfProduct)
    end.

can_partition_helper([], _) -> false;
can_partition_helper([H | T], Target) ->
    case Target rem H of
        0 -> can_partition_helper(T, Target div H) orelse can_partition_helper(T, Target);
        _ -> can_partition_helper(T, Target)
    end.