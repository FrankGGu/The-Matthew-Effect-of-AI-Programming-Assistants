-module(solution).
-export([max_ascending_subarray_sum/1]).

-spec max_ascending_subarray_sum(Nums :: [integer()]) -> integer().
max_ascending_subarray_sum(Nums) ->
    case Nums of
        [] -> 0;
        [H | T] ->
            max_ascending_subarray_sum_helper(T, H, H, H)
    end.

max_ascending_subarray_sum_helper([], MaxSum, CurrentSum, _PrevElement) ->
    max(MaxSum, CurrentSum);
max_ascending_subarray_sum_helper([CurrentElement | Rest], MaxSum, CurrentSum, PrevElement) ->
    if
        CurrentElement > PrevElement ->
            NewCurrentSum = CurrentSum + CurrentElement,
            NewMaxSum = max(MaxSum, NewCurrentSum),
            max_ascending_subarray_sum_helper(Rest, NewMaxSum, NewCurrentSum, CurrentElement);
        true ->
            NewMaxSum = max(MaxSum, CurrentSum),
            NewCurrentSum = CurrentElement,
            max_ascending_subarray_sum_helper(Rest, NewMaxSum, NewCurrentSum, CurrentElement)
    end.