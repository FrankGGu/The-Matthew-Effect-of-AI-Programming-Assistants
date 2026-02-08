-module(solution).
-export([max_consecutive_ones/2]).

-record(queue, {front = [], back = []}).

new_queue() -> #queue{}.

enqueue(Q = #queue{back = Back}, Elem) ->
    Q#queue{back = [Elem | Back]}.

dequeue(Q = #queue{front = [], back = Back}) ->
    case lists:reverse(Back) of
        [] -> {empty, Q}; % Should not happen if NumZerosInQueue > 0
        [H|T] -> {H, Q#queue{front = T, back = []}}
    end;
dequeue(Q = #queue{front = [H|T], back = Back}) ->
    {H, Q#queue{front = T, back = Back}}.

max_consecutive_ones(Nums, K) ->
    solve(Nums, K, 0, new_queue(), 0, 0, 0).

solve([], _K_limit, _LeftIndex, _ZerosQueue, _NumZeros, MaxLength, _CurrentRightIndex) ->
    MaxLength;
solve([H|T], K_limit, LeftIndex, ZerosQueue, NumZeros, MaxLength, CurrentRightIndex) ->
    {TempZerosQueue, TempNumZeros} =
        if H == 0 ->
            {enqueue(ZerosQueue, CurrentRightIndex), NumZeros + 1};
        true ->
            {ZerosQueue, NumZeros}
        end,

    {FinalLeftIndex, FinalZerosQueue, FinalNumZeros} =
        if TempNumZeros > K_limit ->
            {OldestZeroIdx, DequeuedZerosQueue} = dequeue(TempZerosQueue),
            {OldestZeroIdx + 1, DequeuedZerosQueue, TempNumZeros - 1};
        true ->
            {LeftIndex, TempZerosQueue, TempNumZeros}
        end,

    CurrentWindowLength = CurrentRightIndex - FinalLeftIndex + 1,
    NewMaxLength = max(MaxLength, CurrentWindowLength),

    solve(T, K_limit, FinalLeftIndex, FinalZerosQueue, FinalNumZeros, NewMaxLength, CurrentRightIndex + 1).