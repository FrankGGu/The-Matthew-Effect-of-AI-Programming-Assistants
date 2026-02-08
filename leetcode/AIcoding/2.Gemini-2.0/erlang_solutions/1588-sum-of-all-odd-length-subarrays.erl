-module(sum_odd_length_subarrays).
-export([sumOddLengthSubarrays/1]).

sumOddLengthSubarrays(Arr) ->
    sumOddLengthSubarrays(Arr, 1, 0).

sumOddLengthSubarrays(Arr, Len, Acc) when Len > length(Arr) ->
    Acc;
sumOddLengthSubarrays(Arr, Len, Acc) ->
    NewAcc = sumOddLengthSubarrays(Arr, Len, 0, 0, Acc),
    sumOddLengthSubarrays(Arr, Len + 2, NewAcc).

sumOddLengthSubarrays(Arr, Len, Start, SubAcc, Acc) when Start + Len > length(Arr) ->
    Acc + SubAcc;
sumOddLengthSubarrays(Arr, Len, Start, SubAcc, Acc) ->
    Subarray = lists:sublist(Arr, Start + 1, Len),
    NewSubAcc = SubAcc + lists:sum(Subarray),
    sumOddLengthSubarrays(Arr, Len, Start + 1, NewSubAcc, Acc).