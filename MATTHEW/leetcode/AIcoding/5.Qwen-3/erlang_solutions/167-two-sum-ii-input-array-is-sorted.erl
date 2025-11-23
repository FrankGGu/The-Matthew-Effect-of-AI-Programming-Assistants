-module(two_sum_ii).
-export([two_sum/2]).

two_sum(Numbers, Target) ->
    two_sum(Numbers, Target, 1, length(Numbers)).

two_sum(_, _, Left, Right) when Left >= Right ->
    [];
two_sum(Numbers, Target, Left, Right) ->
    Sum = lists:nth(Left, Numbers) + lists:nth(Right, Numbers),
    if
        Sum == Target ->
            [Left, Right];
        Sum < Target ->
            two_sum(Numbers, Target, Left + 1, Right);
        true ->
            two_sum(Numbers, Target, Left, Right - 1)
    end.