-module(max_sum_of_two_non_overlapping_subarrays).
-export([max_sum_twoNoOverlap/2]).

max_sum_twoNoOverlap(Nums, L) ->
    N = length(Nums),
    Left = array:new(N, {default, 0}),
    Right = array:new(N, {default, 0}),

    % Compute max subarray sum of length L from left to right
    Sum = 0,
    Max = 0,
    {Sum1, Max1} = lists:foldl(fun(I, {S, M}) ->
        S1 = S + element(I+1, Nums),
        if I >= L-1 ->
            M1 = max(M, S1),
            {S1 - element(I-L+1+1, Nums), M1};
        true ->
            {S1, M}
        end
    end, {0, 0}, lists:seq(0, N-1)),

    % Fill left array
    {Left1, _} = lists:foldl(fun(I, {Arr, Sum}) ->
        if I >= L-1 ->
            NewSum = Sum + element(I+1, Nums),
            NewArr = array:set(I, max(array:get(I-1, Arr), NewSum), Arr),
            {NewArr, NewSum - element(I-L+1+1, Nums)};
        true ->
            NewArr = array:set(I, array:get(I-1, Arr), Arr),
            {NewArr, Sum + element(I+1, Nums)}
        end
    end, {Left, 0}, lists:seq(0, N-1)),

    % Compute max subarray sum of length L from right to left
    Sum2 = 0,
    Max2 = 0,
    {Sum3, Max3} = lists:foldl(fun(I, {S, M}) ->
        S1 = S + element(I+1, Nums),
        if I >= L-1 ->
            M1 = max(M, S1),
            {S1 - element(I-L+1+1, Nums), M1};
        true ->
            {S1, M}
        end
    end, {0, 0}, lists:reverse(lists:seq(0, N-1))),

    % Fill right array
    {Right1, _} = lists:foldl(fun(I, {Arr, Sum}) ->
        if I >= L-1 ->
            NewSum = Sum + element(I+1, Nums),
            NewArr = array:set(I, max(array:get(I-1, Arr), NewSum), Arr),
            {NewArr, NewSum - element(I-L+1+1, Nums)};
        true ->
            NewArr = array:set(I, array:get(I-1, Arr), Arr),
            {NewArr, Sum + element(I+1, Nums)}
        end
    end, {Right, 0}, lists:reverse(lists:seq(0, N-1)))',

    % Find the maximum sum of two non-overlapping subarrays
    Result = lists:foldl(fun(I, Acc) ->
        LeftVal = array:get(I, Left1),
        RightVal = array:get(I, Right1),
        MaxVal = max(LeftVal, RightVal),
        case I < N - L of
            true -> max(Acc, LeftVal + array:get(I + L, Right1));
            false -> Acc
        end
    end, 0, lists:seq(0, N-1)),

    Result.