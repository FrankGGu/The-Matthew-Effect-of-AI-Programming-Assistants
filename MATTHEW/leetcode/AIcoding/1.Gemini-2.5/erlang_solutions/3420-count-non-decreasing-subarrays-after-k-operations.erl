-module(solution).
-export([count_non_decreasing_subarrays/2]).

get_val(Arr, Idx) ->
    array:get(Idx, Arr).

count_non_decreasing_subarrays(Nums, K) ->
    Arr = array:from_list(Nums),
    N = array:size(Arr),
    count_helper(Arr, K, N, 0, 0, 0, 0).

count_helper(Arr, K, N, RightIdx, LeftIdx, Violations, Total) when RightIdx < N ->
    CurrentNum = get_val(Arr, RightIdx),

    NewViolations = if RightIdx > 0 ->
                        PrevNum = get_val(Arr, RightIdx - 1),
                        if PrevNum > CurrentNum -> Violations + 1;
                           true -> Violations
                        end;
                       true -> Violations
                    end,

    {UpdatedLeftIdx, UpdatedViolations} = 
        shrink_window_loop(Arr, K, RightIdx, LeftIdx, NewViolations),

    NewTotal = Total + (RightIdx - UpdatedLeftIdx + 1),

    count_helper(Arr, K, N, RightIdx + 1, UpdatedLeftIdx, UpdatedViolations, NewTotal);
count_helper(_Arr, _K, _N, _RightIdx, _LeftIdx, _Violations, Total) ->
    Total.

shrink_window_loop(Arr, K, RightIdx, LeftIdx, CurrentViolations) ->
    if CurrentViolations > K ->
        DecrementViolation = if LeftIdx < RightIdx ->
                                 ValLeft = get_val(Arr, LeftIdx),
                                 ValLeftPlus1 = get_val(Arr, LeftIdx + 1),
                                 if ValLeft > ValLeftPlus1 -> 1;
                                    true -> 0
                                 end;
                                true -> 0
                             end,

        shrink_window_loop(Arr, K, RightIdx, LeftIdx + 1, CurrentViolations - DecrementViolation);
    true ->
        {LeftIdx, CurrentViolations}
    end.