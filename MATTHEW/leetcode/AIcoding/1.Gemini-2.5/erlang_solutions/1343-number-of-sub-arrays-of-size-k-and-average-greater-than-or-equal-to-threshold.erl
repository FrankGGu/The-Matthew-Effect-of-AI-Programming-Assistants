-module(solution).
-export([num_of_subarrays/3]).

num_of_subarrays(Arr, K, Threshold) ->
    N = length(Arr),
    if
        N < K -> 0;
        true ->
            TargetSum = K * Threshold,

            {InitialSum, InitialQueue, RemainingArr} = build_initial_queue(Arr, K, 0, queue:new()),

            Count = if InitialSum >= TargetSum -> 1; true -> 0 end,

            slide_with_queue(RemainingArr, K, TargetSum, InitialSum, Count, InitialQueue)
    end.

build_initial_queue([H|T], K, Acc, Q) when K > 0 ->
    build_initial_queue(T, K-1, Acc + H, queue:in(H, Q));
build_initial_queue(List, 0, Acc, Q) ->
    {Acc, Q, List}.

slide_with_queue([], _K, _TargetSum, _CurrentSum, Count, _CurrentQueue) ->
    Count;
slide_with_queue([NewElement|Rest], K, TargetSum, CurrentSum, Count, CurrentQueue) ->
    {value, OldElement, TempQueue} = queue:out(CurrentQueue),
    NewQueue = queue:in(NewElement, TempQueue),

    NewSum = CurrentSum - OldElement + NewElement,
    NewCount = if NewSum >= TargetSum -> Count + 1; true -> Count end,

    slide_with_queue(Rest, K, TargetSum, NewSum, NewCount, NewQueue).