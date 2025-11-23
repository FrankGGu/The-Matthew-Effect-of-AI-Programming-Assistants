-module(solution).
-export([max_freq/2]).

max_freq(Nums, K) ->
    Sorted = lists:sort(Nums),
    N = length(Sorted),
    MaxFreq = 0,
    Left = 0,
    max_freq(Sorted, K, N, Left, MaxFreq).

max_freq(_, _, N, Left, MaxFreq) when Left >= N ->
    MaxFreq;
max_freq(Sorted, K, N, Left, MaxFreq) ->
    Right = Left,
    Current = lists:nth(Right + 1, Sorted),
    Total = 0,
    Count = 0,
    max_freq(Sorted, K, N, Left, Right, Current, Total, Count, MaxFreq).

max_freq(Sorted, K, N, Left, Right, Current, Total, Count, MaxFreq) when Right >= N ->
    max_freq(Sorted, K, N, Left + 1, MaxFreq);
max_freq(Sorted, K, N, Left, Right, Current, Total, Count, MaxFreq) ->
    Next = lists:nth(Right + 2, Sorted),
    NewTotal = Total + (Next - Current),
    if
        NewTotal =< K ->
            max_freq(Sorted, K, N, Left, Right + 1, Next, NewTotal, Count + 1, MaxFreq);
        true ->
            NewMaxFreq = max(MaxFreq, Count + 1),
            max_freq(Sorted, K, N, Left + 1, Right, Next, 0, 0, NewMaxFreq)
    end.