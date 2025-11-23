-module(solution).
-export([min_subarray_sum_divisible_by_p/2]).

min_subarray_sum_divisible_by_p(Nums, P) ->
    TotalSum = lists:sum(Nums),
    TargetRemainder = TotalSum rem P,
    N = length(Nums),

    % Acc: {CurrentSumModP, MinLen, RemainderToIndexMap, CurrentIndex}
    % CurrentSumModP: The prefix sum modulo P up to the current element.
    % MinLen: The minimum length of a subarray found so far that satisfies the condition.
    % RemainderToIndexMap: A map storing {Remainder => LastSeenIndex} for prefix sums modulo P.
    % CurrentIndex: The 0-based index of the current element being processed.
    InitialAcc = {0, N + 1, #{0 => -1}, -1},

    {_FinalSumModP, FinalMinLen, _FinalMap, _FinalIndex} = lists:foldl(
        fun(Num, {CurrentSumModP, MinLen, RemainderToIndexMap, CurrentIndex}) ->
            NewIndex = CurrentIndex + 1,
            NewCurrentSumModP = (CurrentSumModP + Num) rem P,

            % We are looking for a subarray [i..j] such that sum(nums[i..j]) mod P = TargetRemainder.
            % sum(nums[i..j]) = PrefixSum[j+1] - PrefixSum[i].
            % So, (PrefixSum[j+1] - PrefixSum[i]) mod P = TargetRemainder.
            % This means (NewCurrentSumModP - RequiredPrevRemainder + P) mod P = TargetRemainder.
            % Rearranging: RequiredPrevRemainder = (NewCurrentSumModP - TargetRemainder + P) mod P.
            RequiredPrevRemainder = (NewCurrentSumModP - TargetRemainder + P) rem P,

            NewMinLen = case maps:is_key(RequiredPrevRemainder, RemainderToIndexMap) of
                true ->
                    PrevIndex = maps:get(RequiredPrevRemainder, RemainderToIndexMap),
                    SubarrayLen = NewIndex - PrevIndex,
                    min(MinLen, SubarrayLen);
                false ->
                    MinLen
            end,

            NewRemainderToIndexMap = maps:put(NewCurrentSumModP, NewIndex, RemainderToIndexMap),

            {NewCurrentSumModP, NewMinLen, NewRemainderToIndexMap, NewIndex}
        end,
        InitialAcc,
        Nums
    ),

    % Final logic to determine the return value based on FinalMinLen:
    % N + 1: No subarray was found that satisfies the condition.
    % N: The only subarray found that satisfies the condition is the entire array itself.
    % < N: A proper subarray was found.
    case FinalMinLen of
        N + 1 -> -1; % No subarray found, not possible.
        N when TargetRemainder == 0 -> 0; % Total sum is already divisible, and only removing the whole array works.
                                         % This means we remove nothing, so length 0.
        N -> -1; % Total sum was not divisible, and only removing the whole array makes it divisible.
                 % This is not a "proper" subarray removal, so not possible.
        _ -> FinalMinLen % A proper subarray was found.
    end.