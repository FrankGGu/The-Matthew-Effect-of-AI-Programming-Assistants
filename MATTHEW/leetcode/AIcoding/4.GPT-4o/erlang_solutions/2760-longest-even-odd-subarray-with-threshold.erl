-module(solution).
-export([longest_even_odd_subarray/2]).

longest_even_odd_subarray(List, Threshold) ->
    longest_even_odd_subarray(List, Threshold, 0, 0, 0).

longest_even_odd_subarray([], _, MaxLength, _, _) ->
    MaxLength;
longest_even_odd_subarray([H | T], Threshold, MaxLength, CurrentLength, PrevParity) ->
    NewParity = H rem 2,
    NewLength = if
        H > Threshold -> 0;
        NewParity == PrevParity -> CurrentLength + 1;
        true -> 1
    end,
    longest_even_odd_subarray(T, Threshold, max(MaxLength, NewLength), NewLength, NewParity).