-module(min_subarray_sum).
-export([min_subarray_sum/2]).

min_subarray_sum(S, A) ->
    min_subarray_sum(S, A, 0, 0, 0, length(A), infinity).

min_subarray_sum(_, _, Left, Right, CurrentSum, Len, MinLen) when Right >= Len ->
    if MinLen == infinity -> 0;
       true -> MinLen
    end;

min_subarray_sum(S, A, Left, Right, CurrentSum, Len, MinLen) ->
    case CurrentSum of
        Sum when Sum >= S ->
            NewMinLen = min(MinLen, Right - Left),
            NewSum = CurrentSum - lists:nth(Left + 1, A),
            min_subarray_sum(S, A, Left + 1, Right, NewSum, Len, NewMinLen);
        _ ->
            NewSum = CurrentSum + lists:nth(Right + 1, A),
            min_subarray_sum(S, A, Left, Right + 1, NewSum, Len, MinLen)
    end.