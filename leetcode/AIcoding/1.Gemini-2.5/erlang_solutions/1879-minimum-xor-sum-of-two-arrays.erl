-module(solution).
-export([minimumXORSum/2]).

-define(INF, 1_000_000_000_000_000). % A sufficiently large number for infinity

minimumXORSum(Nums1, Nums2) ->
    N = length(Nums1),
    MaxMask = (1 bsl N) - 1,

    % Convert input lists to arrays for O(1) access
    Nums1Arr = array:from_list(Nums1),
    Nums2Arr = array:from_list(Nums2),

    % Initialize DP array
    % dp[mask] stores the minimum XOR sum for the first popcount(mask) elements of Nums1
    % and the elements of Nums2 whose indices are set in mask.
    DP = array:new([{size, MaxMask + 1}, {default, ?INF}]),
    DP1 = array:set(0, 0, DP), % Base case: empty set has XOR sum 0

    % Iterate through all possible masks from 1 to MaxMask
    % The order of iteration ensures that dp[prev_mask] is computed before dp[mask]
    % because prev_mask will always have fewer set bits than mask.
    ResultDP = lists:foldl(fun(Mask, CurrentDP) ->
                               K = erlang:popcount(Mask), % Number of set bits in Mask
                               CurrentNums1Idx = K - 1,   % 0-indexed index for Nums1
                               ValNums1 = array:get(CurrentNums1Idx, Nums1Arr),

                               MinValForMask = lists:foldl(fun(J, AccMin) ->
                                                               % Check if j-th bit is set in Mask
                                                               if (Mask band (1 bsl J)) /= 0 ->
                                                                   PrevMask = Mask bxor (1 bsl J), % Mask without j-th bit
                                                                   PrevDPVal = array:get(PrevMask, CurrentDP),
                                                                   ValNums2 = array:get(J, Nums2Arr),
                                                                   Cost = ValNums1 bxor ValNums2,
                                                                   min(AccMin, PrevDPVal + Cost);
                                                               true ->
                                                                   AccMin
                                                               end
                                                       end, ?INF, lists:seq(0, N - 1)),
                               array:set(Mask, MinValForMask, CurrentDP)
                       end, DP1, lists:seq(1, MaxMask)),

    array:get(MaxMask, ResultDP).