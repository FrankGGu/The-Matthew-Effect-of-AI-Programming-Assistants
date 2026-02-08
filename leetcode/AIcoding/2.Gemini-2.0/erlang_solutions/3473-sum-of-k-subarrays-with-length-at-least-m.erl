-module(solution).
-export([max_sum_of_k_subarrays/3]).

max_sum_of_k_subarrays(Nums, K, M) ->
    N = length(Nums),
    {ok, DP} = ets:new(dp_table, [private, named_table]),
    Result = max_sum_of_k_subarrays_helper(Nums, N, K, M, 0, DP),
    ets:delete(DP),
    Result.

max_sum_of_k_subarrays_helper(_Nums, _N, 0, _M, _Index, _DP) ->
    0;
max_sum_of_k_subarrays_helper(Nums, N, K, M, Index, DP) when Index >= N ->
    -infinity;
max_sum_of_k_subarrays_helper(Nums, N, K, M, Index, DP) ->
    case ets:lookup(DP, {K, Index}) of
        [{_, Value}] ->
            Value;
        [] ->
            Skipped = max_sum_of_k_subarrays_helper(Nums, N, K, M, Index + 1, DP),
            {Sum, MaxSum} = calculate_max_sum(Nums, N, M, Index),
            Taken = if Sum == -infinity then -infinity else Sum + max_sum_of_k_subarrays_helper(Nums, N, K - 1, M, MaxSum, DP) end,
            Result = max(Skipped, Taken),
            ets:insert(DP, {{K, Index}, Result}),
            Result
    end.

calculate_max_sum(Nums, N, M, Index) ->
    if Index + M > N then
        {-infinity, -infinity}
    else
        calculate_max_sum_helper(Nums, N, M, Index, 0, Index, -infinity, -infinity)
    end.

calculate_max_sum_helper(Nums, N, M, Index, CurrentSum, CurrentIndex, MaxSum, MaxIndex) when CurrentIndex < Index + M ->
    NewSum = CurrentSum + lists:nth(CurrentIndex + 1, Nums),
    calculate_max_sum_helper(Nums, N, M, Index, NewSum, CurrentIndex + 1, MaxSum, MaxIndex);
calculate_max_sum_helper(Nums, N, M, Index, CurrentSum, CurrentIndex, MaxSum, MaxIndex) when CurrentIndex =:= Index + M ->
    if CurrentSum > MaxSum then
        {CurrentSum, CurrentIndex}
    else
        {MaxSum, MaxIndex}
    end;
calculate_max_sum_helper(Nums, N, M, Index, CurrentSum, CurrentIndex, MaxSum, MaxIndex) ->
    NewSum = CurrentSum + lists:nth(CurrentIndex + 1, Nums) - lists:nth(Index + 1, Nums),
    if NewSum > MaxSum then
        calculate_max_sum_helper(lists:sublist(Nums, 2, N), N - 1, M, Index + 1, NewSum, CurrentIndex + 1, NewSum, CurrentIndex + 1)
    else
        calculate_max_sum_helper(lists:sublist(Nums, 2, N), N - 1, M, Index + 1, NewSum, CurrentIndex + 1, MaxSum, MaxIndex)
    end.

max(A, B) ->
    if A > B then
        A
    else
        B
    end.