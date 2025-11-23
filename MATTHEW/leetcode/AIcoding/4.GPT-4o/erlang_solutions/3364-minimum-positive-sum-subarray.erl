-module(solution).
-export([min_positive_sum_subarray/1]).

min_positive_sum_subarray(List) ->
    min_positive_sum_subarray(List, 0, 1, 0, infinity).

min_positive_sum_subarray([], CurrentSum, _, Count, Min) ->
    if
        CurrentSum > 0 -> min(Min, CurrentSum);
        true -> Min
    end;
min_positive_sum_subarray([H | T], CurrentSum, Count, CurrentCount, Min) ->
    NewSum = CurrentSum + H,
    NewCount = Count + 1,
    Min1 = min_positive_sum_subarray(T, NewSum, NewCount, CurrentCount, Min),
    Min2 = min_positive_sum_subarray(T, CurrentSum, Count, NewCount, Min1),
    Min2.