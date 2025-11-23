-module(maximum_sum_of_3_non_overlapping_subarrays).
-export([maxSumOfThreeSubarrays/2]).

maxSumOfThreeSubarrays(Nums, K) ->
    Len = length(Nums),
    L = lists:seq(0, Len - 1),
    Sum = fun(I) -> sum(lists:sublist(Nums, I + 1, K)) end,
    Sums = lists:map(Sum, L),
    MaxLeft = max_left(Sums, K),
    MaxRight = max_right(Sums, K),
    Max = 0,
    Result = [],
    loop(0, Len - 1, K, Sums, MaxLeft, MaxRight, Result, Max).

loop(I, J, K, Sums, MaxLeft, MaxRight, Result, Max) when I > J ->
    Result;
loop(I, J, K, Sums, MaxLeft, MaxRight, Result, Max) ->
    Left = lists:nth(I + 1, MaxLeft),
    Right = lists:nth(J + 1, MaxRight),
    Current = lists:nth(I + 1, Sums) + lists:nth(J + 1, Sums) + Left,
    if
        Current > Max ->
            NewResult = [I, I + K, J],
            loop(I + 1, J, K, Sums, MaxLeft, MaxRight, NewResult, Current);
        true ->
            loop(I + 1, J, K, Sums, MaxLeft, MaxRight, Result, Max)
    end.

max_left(Sums, K) ->
    Len = length(Sums),
    MaxLeft = lists:duplicate(Len, 0),
    Max = 0,
    Index = 0,
    loop_left(0, Len - 1, K, Sums, Max, Index, MaxLeft).

loop_left(I, J, K, Sums, Max, Index, MaxLeft) when I > J ->
    MaxLeft;
loop_left(I, J, K, Sums, Max, Index, MaxLeft) ->
    if
        I + K <= J ->
            Current = lists:nth(I + 1, Sums),
            if
                Current > Max ->
                    NewMax = Current,
                    NewIndex = I,
                    lists:put(Index + 1, NewMax, MaxLeft),
                    loop_left(I + 1, J, K, Sums, NewMax, NewIndex, MaxLeft);
                true ->
                    lists:put(Index + 1, Max, MaxLeft),
                    loop_left(I + 1, J, K, Sums, Max, Index, MaxLeft)
            end;
        true ->
            lists:put(Index + 1, Max, MaxLeft),
            loop_left(I + 1, J, K, Sums, Max, Index, MaxLeft)
    end.

max_right(Sums, K) ->
    Len = length(Sums),
    MaxRight = lists:duplicate(Len, 0),
    Max = 0,
    Index = 0,
    loop_right(Len - 1, 0, K, Sums, Max, Index, MaxRight).

loop_right(I, J, K, Sums, Max, Index, MaxRight) when I < J ->
    MaxRight;
loop_right(I, J, K, Sums, Max, Index, MaxRight) ->
    if
        I - K >= J ->
            Current = lists:nth(I + 1, Sums),
            if
                Current > Max ->
                    NewMax = Current,
                    NewIndex = I,
                    lists:put(Index + 1, NewMax, MaxRight),
                    loop_right(I - 1, J, K, Sums, NewMax, NewIndex, MaxRight);
                true ->
                    lists:put(Index + 1, Max, MaxRight),
                    loop_right(I - 1, J, K, Sums, Max, Index, MaxRight)
            end;
        true ->
            lists:put(Index + 1, Max, MaxRight),
            loop_right(I - 1, J, K, Sums, Max, Index, MaxRight)
    end.

sum(List) ->
    sum(List, 0).

sum([], Acc) ->
    Acc;
sum([H | T], Acc) ->
    sum(T, Acc + H).