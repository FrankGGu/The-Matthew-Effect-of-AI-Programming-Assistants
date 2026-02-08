-module(subarray_average).
-export([num_of_subarrays/3]).

num_of_subarrays(Arr, K, Threshold) ->
    Len = length(Arr),
    if Len < K then
        0
    else
        num_of_subarrays_helper(Arr, K, Threshold, 0, K, 0)
    end.

num_of_subarrays_helper(Arr, K, Threshold, Start, End, Count) ->
    Len = length(Arr),
    if End > Len then
        Count
    else
        Subarray = lists:sublist(Arr, Start + 1, K),
        Sum = lists:sum(Subarray),
        Avg = Sum / K,
        if Avg >= Threshold then
            num_of_subarrays_helper(Arr, K, Threshold, Start + 1, End + 1, Count + 1)
        else
            num_of_subarrays_helper(Arr, K, Threshold, Start + 1, End + 1, Count)
        end
    end.