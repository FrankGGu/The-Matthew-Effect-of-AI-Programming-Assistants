-module(solution).
-export([min_subarray_len/2]).

min_subarray_len(S, Nums) ->
    Len = length(Nums),
    InitialMinLen = Len + 1,
    Result = min_subarray_len_queue(S, Nums, [], [], 0, InitialMinLen, 0, 0),
    if Result == InitialMinLen -> 0; else Result end.

min_subarray_len_queue(S, [], In, Out, CurrentSum, MinLen, LeftIdx, RightIdx) ->
    shrink_queue_final(S, In, Out, CurrentSum, MinLen, LeftIdx, RightIdx);
min_subarray_len_queue(S, [H|T], In, Out, CurrentSum, MinLen, LeftIdx, RightIdx) ->
    NewIn = [H|In],
    NewCurrentSum = CurrentSum + H,
    NewRightIdx = RightIdx + 1,

    {ShrunkIn, ShrunkOut, ShrunkSum, ShrunkMinLen, ShrunkLeftIdx} =
        shrink_queue(S, NewIn, Out, NewCurrentSum, MinLen, LeftIdx, NewRightIdx),

    min_subarray_len_queue(S, T, ShrunkIn, ShrunkOut, ShrunkSum, ShrunkMinLen, ShrunkLeftIdx, NewRightIdx).

shrink_queue(S, In, Out, CurrentSum, MinLen, LeftIdx, RightIdx) ->
    if CurrentSum >= S ->
        NewMinLen = min(MinLen, RightIdx - LeftIdx),
        {ElementToRemove, NewIn, NewOut} = dequeue(In, Out),
        NewCurrentSum = CurrentSum - ElementToRemove,
        NewLeftIdx = LeftIdx + 1,
        shrink_queue(S, NewIn, NewOut, NewCurrentSum, NewMinLen, NewLeftIdx, RightIdx);
    else ->
        {In, Out, CurrentSum, MinLen, LeftIdx}
    end.

shrink_queue_final(S, In, Out, CurrentSum, MinLen, LeftIdx, RightIdx) ->
    if CurrentSum >= S ->
        NewMinLen = min(MinLen, RightIdx - LeftIdx),
        {ElementToRemove, NewIn, NewOut} = dequeue(In, Out),
        NewCurrentSum = CurrentSum - ElementToRemove,
        NewLeftIdx = LeftIdx + 1,
        shrink_queue_final(S, NewIn, NewOut, NewCurrentSum, NewMinLen, NewLeftIdx, RightIdx);
    else ->
        MinLen
    end.

dequeue(In, [H|T]) ->
    {H, In, T};
dequeue(In, []) ->
    NewOut = lists:reverse(In),
    dequeue([], NewOut).