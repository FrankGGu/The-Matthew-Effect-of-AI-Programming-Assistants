-module(maximum_subarray_sum).
-export([max_sum_div_k/2]).

max_sum_div_k(Nums, K) ->
    N = length(Nums),
    max_sum_div_k_helper(Nums, K, 0, 0, 0, 0, 0).

max_sum_div_k_helper([], _, _, MaxSum, _, _, _) -> MaxSum;
max_sum_div_k_helper([H | T], K, CurSum, MaxSum, Count, StartIndex, EndIndex) ->
    NewCurSum = CurSum + H,
    NewCount = Count + 1,
    NewStartIndex = StartIndex,
    NewEndIndex = EndIndex + 1,
    if
        NewCount < K ->
            max_sum_div_k_helper(T, K, NewCurSum, MaxSum, NewCount, NewStartIndex, NewEndIndex);
        NewCount == K ->
            NewMaxSum = max(MaxSum, NewCurSum),
            max_sum_div_k_helper(T, K, NewCurSum, NewMaxSum, NewCount, NewStartIndex + 1, NewEndIndex);
        true ->
            NewSum = NewCurSum - lists:nth(NewStartIndex + 1, [H | T]),
            NewMaxSum = max(MaxSum, NewSum),
            max_sum_div_k_helper(T, K, NewSum, NewMaxSum, NewCount, NewStartIndex + 1, NewEndIndex)
    end.