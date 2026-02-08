-module(solution).
-export([make_k_subarray_sums_equal/2]).

make_k_subarray_sums_equal(Array, K) ->
    N = length(Array),
    TotalSum = lists:sum(Array),
    if 
        TotalSum rem K =/= 0 -> 
            false;
        true -> 
            TargetSum = TotalSum div K,
            make_k_subarray_sums_equal_helper(Array, K, TargetSum, 0, 0)
    end.

make_k_subarray_sums_equal_helper([], 0, 0, 0, 0) -> 
    true;
make_k_subarray_sums_equal_helper([], _, _, _, _) -> 
    false;
make_k_subarray_sums_equal_helper([H | T], K, TargetSum, CurrentSum, Count) ->
    NewSum = CurrentSum + H,
    if 
        NewSum > TargetSum -> 
            false;
        NewSum == TargetSum -> 
            make_k_subarray_sums_equal_helper(T, K - 1, TargetSum, 0, Count + 1);
        true -> 
            make_k_subarray_sums_equal_helper(T, K, TargetSum, NewSum, Count)
    end.