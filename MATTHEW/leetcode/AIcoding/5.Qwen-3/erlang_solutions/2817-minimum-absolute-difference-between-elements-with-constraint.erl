-module(minimum_absolute_difference).
-export([minimumAbsoluteDifference/2]).

minimumAbsoluteDifference(List, Target) ->
    Sorted = lists:sort(List),
    min_abs_diff(Sorted, Target, infinity).

min_abs_diff([], _, Acc) ->
    Acc;
min_abs_diff([H | T], Target, Acc) ->
    Diff = abs(H - Target),
    NewAcc = if
        Diff < Acc -> Diff;
        true -> Acc
    end,
    min_abs_diff(T, Target, NewAcc).