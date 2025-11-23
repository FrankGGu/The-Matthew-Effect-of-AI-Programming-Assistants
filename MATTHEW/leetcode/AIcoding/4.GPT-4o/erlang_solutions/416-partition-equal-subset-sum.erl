-module(solution).
-export([can_partition/1]).

%% Check if it's possible to partition the nums list into two subsets with equal sum.
-spec can_partition([integer()]) -> boolean().
can_partition(Nums) ->
    Sum = lists:sum(Nums),
    %% If the sum is odd, it is not possible to partition into two equal subsets.
    case Sum rem 2 of
        1 -> false;  %% Sum is odd, partition not possible
        0 -> can_partition_with_sum(Nums, Sum div 2)
    end.

%% Helper function to check if a subset with a given sum exists using dynamic programming.
-spec can_partition_with_sum([integer()], integer()) -> boolean().
can_partition_with_sum(Nums, TargetSum) ->
    %% DP array: dp[i] will be true if a subset sum of i can be formed.
    can_partition_dp(Nums, [true | lists:duplicate(TargetSum, false)], TargetSum).

%% DP implementation to check subset sum.
-spec can_partition_dp([integer()], [boolean()], integer()) -> boolean().
can_partition_dp([], Dp, _) -> lists:nth(length(Dp), Dp);
can_partition_dp([Head | Tail], Dp, TargetSum) ->
    NewDp = lists:foldl(fun(Idx, Acc) ->
                             if
                                 Acc =:= TargetSum -> Acc; %% If we reached the target, no need to check further.
                                 true -> Acc;
                                 false -> Acc
                             end
                         end, Dp),
    can_partition_dp(Tail, NewDp, TargetSum).
