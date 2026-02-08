-module(max_frequency_after_subarray_operation).
-export([maxFrequency/2]).

maxFrequency(Nums, K) ->
    maxFrequency(Nums, K, 0, 0, 0, 0).

maxFrequency([], _, _, _, _, _) ->
    0;
maxFrequency([H | T], K, Left, CurrentSum, MaxFreq, Count) ->
    CurrentSum1 = CurrentSum + H,
    Count1 = Count + 1,
    while_left(H, T, K, Left, CurrentSum1, Count1, MaxFreq).

while_left(H, T, K, Left, CurrentSum, Count, MaxFreq) ->
    if
        CurrentSum - (Left * H) > K ->
            NewLeft = Left + 1,
            NewCurrentSum = CurrentSum - H,
            NewCount = Count - 1,
            while_left(H, T, K, NewLeft, NewCurrentSum, NewCount, MaxFreq);
        true ->
            NewMaxFreq = max(MaxFreq, Count),
            maxFrequency(T, K, Left, CurrentSum, NewMaxFreq, Count)
    end.