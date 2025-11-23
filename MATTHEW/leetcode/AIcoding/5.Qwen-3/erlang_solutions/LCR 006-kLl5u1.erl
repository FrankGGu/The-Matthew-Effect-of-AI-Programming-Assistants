-module(two_sum_ii).
-export([two_sum/1]).

two_sum(Nums) ->
    two_sum(Nums, 1, length(Nums), 0).

two_sum(Nums, Left, Right, Target) ->
    case Left >= Right of
        true -> [];
        false ->
            LVal = lists:nth(Left, Nums),
            RVal = lists:nth(Right, Nums),
            Sum = LVal + RVal,
            if
                Sum == Target -> [Left, Right];
                Sum < Target -> two_sum(Nums, Left + 1, Right, Target);
                true -> two_sum(Nums, Left, Right - 1, Target)
            end
    end.