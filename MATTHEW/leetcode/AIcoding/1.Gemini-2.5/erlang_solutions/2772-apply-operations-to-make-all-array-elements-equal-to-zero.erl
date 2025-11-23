-module(solution).
-export([checkArray/2]).

checkArray(Nums, K) ->
    Len = length(Nums),
    check(0, Len, K, Nums, queue:new(), 0).

check(Idx, Len, K, Nums, Queue, CurrentReduction) when Idx < Len ->
    {UpdatedQueue, UpdatedCurrentReduction} = remove_expired(Queue, CurrentReduction, Idx),

    Num_i = lists:nth(Idx + 1, Nums),
    EffectiveVal = Num_i - UpdatedCurrentReduction,

    if EffectiveVal > 0 ->
        if Idx + K > Len ->
            false;
        true ->
            NewQueue = queue:in({EffectiveVal, Idx + K - 1}, UpdatedQueue),
            NewCurrentReduction = UpdatedCurrentReduction + EffectiveVal,
            check(Idx + 1, Len, K, Nums, NewQueue, NewCurrentReduction)
        end;
    true ->
        check(Idx + 1, Len, K, Nums, UpdatedQueue, UpdatedCurrentReduction)
    end;
check(Idx, Len, _K, _Nums, _Queue, _CurrentReduction) when Idx == Len ->
    true.

remove_expired(Q, CR, CurrentIndex) ->
    case queue:peek(Q) of
        {value, {Val, EndIndex}} when EndIndex < CurrentIndex ->
            {_Value, Q1} = queue:out(Q),
            remove_expired(Q1, CR - Val, CurrentIndex);
        _ ->
            {Q, CR}
    end.