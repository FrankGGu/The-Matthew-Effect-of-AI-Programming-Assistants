-spec sum_of_k_subarrays_with_length_at_least_m(Nums :: [integer()], K :: integer(), M :: integer()) -> integer().
sum_of_k_subarrays_with_length_at_least_m(Nums, K, M) ->
    N = length(Nums),
    % Calculate prefix sums: ps[i] = sum(Nums[0...i-1]), ps[0] = 0
    % PrefixSums will be [0, Nums[0], Nums[0]+Nums[1], ..., sum(Nums)]
    % The length of PrefixSums list is N + 1.
    % To access ps[idx] (0-indexed conceptual array), use lists:nth(idx + 1, PrefixSums).
    PrefixSums = lists:foldl(fun(X, Acc) -> Acc ++ [lists:last(Acc) + X] end, [0], Nums),

    % Call a helper function for the main loop
    % J iterates from 0 to N-1, representing the end index of a potential subarray.
    % CurrentCount accumulates the number of valid subarrays.
    % SlidingWindowMap stores frequencies of prefix sums ps[i] where i <= J - M + 1.
    Count = solve_optimized(N, K, M, PrefixSums, 0, 0, #{}),

    K * Count.

solve_optimized(N, K, M, PrefixSums, J, CurrentCount, SlidingWindowMap) when J < N ->
    % CurrentPrefixSum is ps[J+1], which is sum(Nums[0...J])
    CurrentPrefixSum = lists:nth(J + 2, PrefixSums), % lists:nth is 1-indexed, so (J+1)-th element is at position J+2

    NewSlidingWindowMap = if J >= M - 1 ->
                              % The prefix sum ps[J - M + 1] becomes eligible to start a subarray of length >= M ending at J.
                              % This is ps[i] where i = J - M + 1.
                              IndexForPsI = J - M + 1,
                              PsValueToAdd = lists:nth(IndexForPsI + 1, PrefixSums), % ps[IndexForPsI]
                              % Add PsValueToAdd to the frequency map
                              maps:update_with(PsValueToAdd, fun(V) -> V + 1 end, 1, SlidingWindowMap);
                          true ->
                              SlidingWindowMap
                          end,

    % We are looking for a ps[i] such that CurrentPrefixSum - ps[i] == K
    % This means ps[i] = CurrentPrefixSum - K.
    TargetPsI = CurrentPrefixSum - K,

    % Query the map for the count of TargetPsI. These are the valid starting points.
    Matches = maps:get(TargetPsI, NewSlidingWindowMap, 0),

    NewCurrentCount = CurrentCount + Matches,

    % Continue to the next J
    solve_optimized(N, K, M, PrefixSums, J + 1, NewCurrentCount, NewSlidingWindowMap);
solve_optimized(_N, _K, _M, _PrefixSums, _J, CurrentCount, _SlidingWindowMap) ->
    CurrentCount.