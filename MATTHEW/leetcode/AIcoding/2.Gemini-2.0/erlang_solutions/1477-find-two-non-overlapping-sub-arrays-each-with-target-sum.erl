-module(find_two_non_overlapping_sub_arrays).
-export([find_two_non_overlapping_sub_arrays/2]).

find_two_non_overlapping_sub_arrays(Arr, Target) ->
    N = length(Arr),
    Left = lists:duplicate(N, 100001),
    Right = lists:duplicate(N, 100001),
    MinLen = 100001,
    Sum = 0,
    Start = 0,
    for(I, 1, N,
        begin
            Sum = Sum + lists:nth(I, Arr),
            while Sum > Target do
                Sum = Sum - lists:nth(Start + 1, Arr),
                Start = Start + 1
            end,
            if Sum == Target then
                Len = I - Start,
                MinLen = min(MinLen, Len),
                lists:nth_set(I, Left, MinLen)
            end,
            if I > 1 then
                lists:nth_set(I, Left, min(lists:nth(I, Left), lists:nth(I - 1, Left)))
            end
        end),
    MinLen = 100001,
    Sum = 0,
    Start = N - 1,
    for(I, N, 1, -1,
        begin
            Sum = Sum + lists:nth(I, Arr),
            while Sum > Target do
                Sum = Sum - lists:nth(Start + 1, Arr),
                Start = Start - 1
            end,
            if Sum == Target then
                Len = Start - I + 1,
                MinLen = min(MinLen, Len),
                lists:nth_set(I, Right, MinLen)
            end,
            if I < N then
                lists:nth_set(I, Right, min(lists:nth(I, Right), lists:nth(I + 1, Right)))
            end
        end),
    Ans = 100001,
    for(I, 1, N - 1,
        begin
            Ans = min(Ans, lists:nth(I, Left) + lists:nth(I + 1, Right))
        end),
    if Ans >= 100001 then
        -1
    else
        Ans
    end.

for(I, Start, End, Step, Body) ->
    for(I, Start, End, Step, Body, ok).

for(I, Start, End, Step, Body, Acc) when Start > End and Step > 0 ->
    Acc;
for(I, Start, End, Step, Body, Acc) when Start < End and Step < 0 ->
    Acc;
for(I, Start, End, Step, Body, Acc) ->
    Body,
    for(I + Step, Start, End, Step, Body, Acc).