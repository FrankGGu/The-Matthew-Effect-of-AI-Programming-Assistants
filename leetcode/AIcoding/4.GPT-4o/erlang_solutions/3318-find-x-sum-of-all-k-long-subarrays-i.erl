-module(solution).
-export([x_sum/2]).

x_sum(List, K) ->
    Length = length(List),
    if
        Length < K -> 0;
        true -> x_sum_helper(List, K, 0, 0)
    end.

x_sum_helper(_, 0, Acc, Acc) -> Acc;
x_sum_helper([], _, _, Acc) -> Acc;
x_sum_helper([H | T], K, Count, Acc) ->
    NewAcc = Acc + H,
    if
        Count < K - 1 -> x_sum_helper(T, K, Count + 1, NewAcc);
        true -> x_sum_helper(T, K, Count - 1, NewAcc - hd(T))
    end.