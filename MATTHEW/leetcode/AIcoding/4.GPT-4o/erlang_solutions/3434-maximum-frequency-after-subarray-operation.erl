-module(solution).
-export([max_frequency/1]).

max_frequency(Arr) ->
    N = length(Arr),
    SortedArr = lists:sort(Arr),
    max_frequency_helper(SortedArr, 0, 0, 0, 0).

max_frequency_helper([], _, MaxFreq, _, _) -> 
    MaxFreq;
max_frequency_helper([H | T], CurrentSum, CurrentFreq, MaxFreq, Total) ->
    NewSum = CurrentSum + H,
    NewFreq = CurrentFreq + 1,
    NewTotal = Total + H,
    if 
        NewSum - Total > CurrentFreq * (H + 1) -> 
            max_frequency_helper(T, NewSum-H, CurrentFreq-1, MaxFreq, Total);
        true -> 
            max_frequency_helper(T, NewSum, NewFreq, max(MaxFreq, NewFreq), Total)
    end.