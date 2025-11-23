-module(solution).
-export([can_partition/1]).

can_partition(Nums) ->
    Sum = lists:sum(Nums),
    if
        Sum rem 2 =:= 1 -> false;
        true -> 
            Target = Sum div 2,
            can_partition_helper(Nums, Target, length(Nums))
    end.

can_partition_helper(_, 0, _) -> true;
can_partition_helper([], _, _) -> false;
can_partition_helper(Nums, Target, N) when Target < 0 -> false;
can_partition_helper(Nums, Target, N) ->
    can_partition_helper(Nums, Target, N - 1) orelse 
    can_partition_helper(Nums, Target - lists:nth(N, Nums), N - 1).