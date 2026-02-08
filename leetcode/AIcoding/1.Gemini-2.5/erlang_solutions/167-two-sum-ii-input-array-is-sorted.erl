-module(solution).
-export([two_sum/2]).

two_sum(Numbers, Target) ->
    Arr = array:from_list(Numbers),
    Len = array:size(Arr),
    two_sum_recursive(Arr, Target, 0, Len - 1).

two_sum_recursive(Arr, Target, Left, Right) ->
    LeftValue = array:get(Left, Arr),
    RightValue = array:get(Right, Arr),
    Sum = LeftValue + RightValue,
    case Sum of
        Target ->
            [Left + 1, Right + 1];
        _ when Sum < Target ->
            two_sum_recursive(Arr, Target, Left + 1, Right);
        _ -> % Sum > Target
            two_sum_recursive(Arr, Target, Left, Right - 1)
    end.