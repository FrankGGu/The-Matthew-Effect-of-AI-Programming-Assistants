-module(solution).
-export([two_sum/2]).

two_sum(Nums, Target) ->
    two_sum_helper(Nums, Target, 1, length(Nums)).

two_sum_helper(Nums, Target, Left, Right) when Left < Right ->
    Sum = lists:nth(Left, Nums) + lists:nth(Right, Nums),
    case Sum of
        Target -> {Left, Right};
        _ when Sum < Target -> two_sum_helper(Nums, Target, Left + 1, Right);
        _ -> two_sum_helper(Nums, Target, Left, Right - 1)
    end.