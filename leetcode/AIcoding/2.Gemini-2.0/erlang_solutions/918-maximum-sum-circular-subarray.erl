-module(max_circular_subarray).
-export([maxSubarraySumCircular/1]).

maxSubarraySumCircular(A) ->
    maxSubarraySumCircular(A, 0, 0, lists:len(A), 0, 0, hd(A), hd(A)).

maxSubarraySumCircular([], _, _, _, MaxSoFar, _, _, _) ->
    MaxSoFar;
maxSubarraySumCircular([H|T], CurrentMax, CurrentMin, Len, Index, TotalSum, MaxSoFar, MinSoFar) ->
    NewTotalSum = TotalSum + H,
    NewCurrentMax = max(H, CurrentMax + H),
    NewMaxSoFar = max(MaxSoFar, NewCurrentMax),
    NewCurrentMin = min(H, CurrentMin + H),
    NewMinSoFar = min(MinSoFar, NewCurrentMin),
    if Index == Len - 1 then
        if NewMaxSoFar > 0 then
            max(NewMaxSoFar, NewTotalSum - NewMinSoFar)
        else
            NewMaxSoFar
        else
        maxSubarraySumCircular(T, NewCurrentMax, NewCurrentMin, Len, Index + 1, NewTotalSum, NewMaxSoFar, NewMinSoFar)
    end.

max(A, B) ->
    if A > B then
        A
    else
        B
    end.

min(A, B) ->
    if A < B then
        A
    else
        B
    end.