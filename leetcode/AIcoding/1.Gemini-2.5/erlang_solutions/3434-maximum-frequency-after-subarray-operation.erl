-module(solution).
-export([max_frequency/2]).

max_frequency(Nums, K) ->
    SortedNums = lists:sort(Nums),
    Arr = array:from_list(SortedNums),
    N = array:size(Arr),
    max_frequency_sliding_window(0, -1, 0, 0, K, Arr, N).

max_frequency_sliding_window(Left, Right, CurrentWindowSum, MaxFreq, K, Arr, N) ->
    NewRight = Right + 1,
    if
        NewRight == N ->
            MaxFreq;
        true ->
            NumRight = array:get(NewRight, Arr),
            NewCurrentWindowSum = CurrentWindowSum + NumRight,

            WindowLength = NewRight - Left + 1,
            Cost = WindowLength * NumRight - NewCurrentWindowSum,

            if
                Cost =< K ->
                    NewMaxFreq = max(MaxFreq, WindowLength),
                    max_frequency_sliding_window(Left, NewRight, NewCurrentWindowSum, NewMaxFreq, K, Arr, N);
                true ->
                    NumLeft = array:get(Left, Arr),
                    ShrunkCurrentWindowSum = NewCurrentWindowSum - NumLeft,
                    max_frequency_sliding_window(Left + 1, NewRight, ShrunkCurrentWindowSum, MaxFreq, K, Arr, N)
            end
    end.