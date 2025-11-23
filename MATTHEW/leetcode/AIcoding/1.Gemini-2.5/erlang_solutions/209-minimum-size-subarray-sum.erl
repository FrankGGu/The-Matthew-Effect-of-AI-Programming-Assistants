-module(solution).
-export([min_subarray_len/2]).

min_subarray_len(S, Nums) ->
    Len = length(Nums),
    % Initial MinLen is Len + 1, representing infinity.
    % LeftIndex starts at 0.
    % RightIndex starts at -1, as it will be incremented before processing the first element.
    % CurrentSum starts at 0.
    ResultMinLen = min_subarray_len_recursive(S, Nums, Nums, 0, -1, 0, Len + 1),

    % If ResultMinLen is still Len + 1, it means no valid subarray was found.
    case ResultMinLen > Len of
        true -> 0;
        false -> ResultMinLen
    end.

min_subarray_len_recursive(S, [RH|RT], LeftListHead, LeftIndex, RightIndex, CurrentSum, MinLen) ->
    NewRightIndex = RightIndex + 1,
    NewCurrentSum = CurrentSum + RH,

    % Try to shrink the window from the left while CurrentSum >= S
    % The shrink_window function returns the updated state of the left pointer and sum.
    {UpdatedLeftListHead, UpdatedLeftIndex, UpdatedCurrentSum, UpdatedMinLen} =
        shrink_window(S, LeftListHead, LeftIndex, NewRightIndex, NewCurrentSum, MinLen),

    % Continue processing the rest of the RightList
    min_subarray_len_recursive(S, RT, UpdatedLeftListHead, UpdatedLeftIndex, NewRightIndex, UpdatedCurrentSum, UpdatedMinLen);

min_subarray_len_recursive(_S, [], _LeftListHead, _LeftIndex, _RightIndex, _CurrentSum, MinLen) ->
    MinLen.

shrink_window(S, LeftListHead, LeftIndex, RightIndex, CurrentSum, MinLen) when CurrentSum >= S ->
    % Update MinLen with the current window length
    CurrentWindowLen = RightIndex - LeftIndex + 1,
    NewMinLen = min(MinLen, CurrentWindowLen),

    % Remove the leftmost element from the window
    LH = hd(LeftListHead),
    NewLeftListHead = tl(LeftListHead),
    NewCurrentSum = CurrentSum - LH,
    NewLeftIndex = LeftIndex + 1,

    % Recursively try to shrink more
    shrink_window(S, NewLeftListHead, NewLeftIndex, RightIndex, NewCurrentSum, NewMinLen);

shrink_window(_S, LeftListHead, LeftIndex, _RightIndex, CurrentSum, MinLen) ->
    % Return the current state of the left pointer and sum.
    {LeftListHead, LeftIndex, CurrentSum, MinLen}.