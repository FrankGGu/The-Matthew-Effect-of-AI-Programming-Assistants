-module(max_subarray_sum_with_length_divisible_by_k).
-export([maxSubarraySum/2]).

maxSubarraySum(Nums, K) ->
    N = length(Nums),
    {MaxSum, _} = lists:foldl(fun(I, {CurrentSum, PrefixSums}) ->
        CurrentSum1 = case I of
            0 -> 0;
            _ -> CurrentSum + lists:nth(I+1, Nums)
        end,
        NewPrefixSums = maps:put(I, CurrentSum1, PrefixSums),
        if
            I rem K == 0 ->
                MaxSum = lists:foldl(fun({J, Sum}, Acc) ->
                    if
                        (I - J) rem K == 0 ->
                            max(Acc, CurrentSum1 - Sum);
                        true ->
                            Acc
                    end
                end, -infinity, maps:to_list(NewPrefixSums));
            true ->
                MaxSum = -infinity
        end,
        {CurrentSum1, NewPrefixSums}
    end, {-infinity, #{}}, lists:seq(0, N-1)),
    MaxSum.

max(A, B) when A > B -> A;
max(_, B) -> B.