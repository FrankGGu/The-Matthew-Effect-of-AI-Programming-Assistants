-module(longest_subarray_with_max_bitwise_and).
-export([longestSubarray/1]).

longestSubarray(Nums) ->
    Max = lists:max(Nums),
    Count = 0,
    longestSubarray(Nums, Max, Count, 0).

longestSubarray([], _, _, Acc) ->
    Acc;
longestSubarray([H | T], Max, Count, Acc) ->
    if
        H == Max ->
            NewCount = Count + 1,
            NewAcc = max(Acc, NewCount),
            longestSubarray(T, Max, NewCount, NewAcc);
        true ->
            longestSubarray(T, Max, 0, Acc)
    end.