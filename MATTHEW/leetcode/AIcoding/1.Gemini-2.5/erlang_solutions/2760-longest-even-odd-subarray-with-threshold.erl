-module(solution).
-export([longest_even_odd_subarray_with_threshold/2]).

longest_even_odd_subarray_with_threshold(Nums, Threshold) ->
    longest_even_odd_subarray_with_threshold_helper(Nums, Threshold, 0, 0, -1).

longest_even_odd_subarray_with_threshold_helper([], _Threshold, MaxLen, _CurrentLen, _PrevNum) ->
    MaxLen;
longest_even_odd_subarray_with_threshold_helper([H | T], Threshold, MaxLen, CurrentLen, PrevNum) ->
    if
        H > Threshold ->
            longest_even_odd_subarray_with_threshold_helper(T, Threshold, MaxLen, 0, -1);
        CurrentLen == 0 ->
            if
                (H rem 2) == 0 -> % H is even, can start a new subarray
                    NewCurrentLen = 1,
                    NewMaxLen = max(MaxLen, NewCurrentLen),
                    longest_even_odd_subarray_with_threshold_helper(T, Threshold, NewMaxLen, NewCurrentLen, H);
                true -> % H is odd, cannot start a new subarray
                    longest_even_odd_subarray_with_threshold_helper(T, Threshold, MaxLen, 0, -1)
            end;
        true -> % CurrentLen > 0, extending an existing subarray
            if
                (PrevNum rem 2) /= (H rem 2) -> % Different parities
                    NewCurrentLen = CurrentLen + 1,
                    NewMaxLen = max(MaxLen, NewCurrentLen),
                    longest_even_odd_subarray_with_threshold_helper(T, Threshold, NewMaxLen, NewCurrentLen, H);
                true -> % Same parities, current sequence broken
                    if
                        (H rem 2) == 0 -> % H is even, can start a new subarray
                            NewCurrentLen = 1,
                            NewMaxLen = max(MaxLen, NewCurrentLen),
                            longest_even_odd_subarray_with_threshold_helper(T, Threshold, NewMaxLen, NewCurrentLen, H);
                        true -> % H is odd, cannot start a new subarray
                            longest_even_odd_subarray_with_threshold_helper(T, Threshold, MaxLen, 0, -1)
                    end
            end
    end.