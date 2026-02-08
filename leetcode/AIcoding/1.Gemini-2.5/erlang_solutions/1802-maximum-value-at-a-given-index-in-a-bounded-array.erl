-module(solution).
-export([maxValue/3]).

maxValue(N, Index, MaxSum) ->
    Low = 1,
    High = MaxSum,
    Ans = 0,
    binary_search(Low, High, N, Index, MaxSum, Ans).

binary_search(Low, High, N, Index, MaxSum, CurrentAns) ->
    if
        Low > High ->
            CurrentAns;
        true ->
            Mid = Low + (High - Low) div 2,
            case check(Mid, N, Index, MaxSum) of
                true ->
                    binary_search(Mid + 1, High, N, Index, MaxSum, Mid);
                false ->
                    binary_search(Low, Mid - 1, N, Index, MaxSum, CurrentAns)
            end
    end.

check(K, N, Index, MaxSum) ->
    LeftLen = Index,
    RightLen = N - 1 - Index,
    TotalSum = K + get_sum(K - 1, LeftLen) + get_sum(K - 1, RightLen),
    TotalSum =< MaxSum.

get_sum(Val, Len) ->
    if
        Len =< 0 ->
            0;
        Val =< 0 ->
            Len;
        Len >= Val ->
            SumTo1 = Val * (Val + 1) div 2,
            NumOnesAfter1 = Len - Val,
            SumTo1 + NumOnesAfter1;
        true ->
            (Val + Val - Len + 1) * Len div 2
    end.