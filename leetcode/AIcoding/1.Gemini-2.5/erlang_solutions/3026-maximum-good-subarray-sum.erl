-module(solution).
-export([maximumGoodSubarraySum/2]).

maximumGoodSubarraySum(Nums, K) ->
    % InitialState: {MaxSum, CurrentPrefixSum, MinPrefixPrefixSumForValMap, FoundGoodSubarray}
    % MaxSum: Stores the maximum good subarray sum found so far. Initialized to a very small number.
    % CurrentPrefixSum: The prefix sum up to the previous element (P[j-1]).
    % MinPrefixPrefixSumForValMap: A gb_trees map where key is a number (Val) and value is the minimum prefix sum *before* an occurrence of Val.
    %                              Specifically, stores min(P[x-1]) for Nums[x] = Val.
    % FoundGoodSubarray: Boolean flag to indicate if at least one good subarray was found.
    InitialState = {min_int_val(), 0, gb_trees:empty(), false},

    {FinalMaxSum, _, _, FinalFoundGoodSubarray} = lists:foldl(
        fun(Num, {AccMaxSum, AccPrefixSum, AccMinPrefixMap, AccFound}) ->
            % AccPrefixSum here is P[j-1] (prefix sum up to previous element)
            % NewPrefixSum will be P[j] (prefix sum up to current element)
            NewPrefixSum = AccPrefixSum + Num,

            CurrentMaxSum = AccMaxSum,
            CurrentFound = AccFound,

            % Handle K=0 case for single element subarray [Num]
            % If K=0, any single element forms a good subarray (abs(Num - Num) == 0).
            % Its sum is Num. We update MaxSum if this is greater.
            {UpdatedMaxSum0, UpdatedFound0} =
                case K of
                    0 ->
                        {max(CurrentMaxSum, Num), true};
                    _ ->
                        {CurrentMaxSum, CurrentFound}
                end,

            Target1 = Num - K,
            Target2 = Num + K,

            % Check for Target1 (Num - K) in the map.
            % If Target1 was seen at Nums[i], then abs(Nums[i] - Nums[j]) == K.
            % We need to find the minimum P[i-1] for Nums[i] = Target1 to maximize P[j] - P[i-1].
            {UpdatedMaxSum1, UpdatedFound1} =
                case gb_trees:lookup(Target1, AccMinPrefixMap) of
                    {value, MinPS1} ->
                        NewMax = max(UpdatedMaxSum0, NewPrefixSum - MinPS1),
                        {NewMax, true};
                    _ ->
                        {UpdatedMaxSum0, UpdatedFound0}
                end,

            % Check for Target2 (Num + K) in the map.
            % Similar logic for Nums[i] = Target2.
            {UpdatedMaxSum2, UpdatedFound2} =
                case gb_trees:lookup(Target2, AccMinPrefixMap) of
                    {value, MinPS2} ->
                        NewMax = max(UpdatedMaxSum1, NewPrefixSum - MinPS2),
                        {NewMax, true};
                    _ ->
                        {UpdatedMaxSum1, UpdatedFound1}
                end,

            % Update MinPrefixMap for the current Num.
            % We store AccPrefixSum (which is P[j-1]) as a candidate for the minimum prefix sum *before* Num (Nums[j]).
            PrevMinPSForNum = gb_trees:get(Num, AccMinPrefixMap, infinity_val()),
            NewMinPrefixMap = gb_trees:insert(Num, min(PrevMinPSForNum, AccPrefixSum), AccMinPrefixMap),

            {UpdatedMaxSum2, NewPrefixSum, NewMinPrefixMap, UpdatedFound2}
        end,
        InitialState,
        Nums
    ),

    % If no good subarray was found, return 0. Otherwise, return the maximum sum found.
    case FinalFoundGoodSubarray of
        true -> FinalMaxSum;
        false -> 0
    end.

max(A, B) when A > B -> A;
max(A, B) -> B.

min(A, B) when A < B -> A;
min(A, B) -> B.

infinity_val() -> 100000000000000000.

min_int_val() -> -100000000000000000.