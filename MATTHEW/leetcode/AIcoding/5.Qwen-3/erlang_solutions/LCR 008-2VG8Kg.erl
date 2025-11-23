-module(min_subarray_len).
-export([minSubArrayLen/2]).

minSubArrayLen(0, _) -> 0;
minSubArrayLen(_, []) -> 0;
minSubArrayLen(S, Arr) ->
    min_subarray_len(S, Arr, 0, 0, 0, length(Arr), 0).

min_subarray_len(_, _, Left, Right, CurrentSum, Len, MinLen) when Right >= Len ->
    if CurrentSum >= S -> MinLen;
       true -> 0
    end;
min_subarray_len(S, Arr, Left, Right, CurrentSum, Len, MinLen) ->
    case CurrentSum of
        Sum when Sum < S ->
            NewSum = CurrentSum + lists:nth(Right + 1, Arr),
            min_subarray_len(S, Arr, Left, Right + 1, NewSum, Len, MinLen);
        _ ->
            NewMinLen = if MinLen == 0 -> Right - Left + 1; true -> min(MinLen, Right - Left + 1) end,
            NewSum = CurrentSum - lists:nth(Left + 1, Arr),
            min_subarray_len(S, Arr, Left + 1, Right, NewSum, Len, NewMinLen)
    end.