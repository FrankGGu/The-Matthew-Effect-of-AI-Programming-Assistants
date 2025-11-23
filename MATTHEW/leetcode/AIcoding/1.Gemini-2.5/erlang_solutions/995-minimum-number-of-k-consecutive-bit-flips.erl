-module(solution).
-export([min_k_bit_flips/2]).

min_k_bit_flips(Nums, K) ->
    N = length(Nums),
    % FlipDiffArray tracks the net change in the number of active flips at each index.
    % If a flip starts at index `i`, it contributes +1 to active flips from `i` onwards.
    % Its effect ends at `i + K - 1`, so at index `i + K`, the contribution stops,
    % which means we decrement the active flips count at `i + K`.
    % The array size needs to accommodate index `N` for the decrement.
    FlipDiffArray = array:new({size, N + 1}, 0),

    % Helper function for iteration.
    % Nums: The remaining part of the input list.
    % K: The length of consecutive flips.
    % N: The total length of the original Nums list.
    % Idx: The current index being processed (0-based).
    % CumulativeFlipEffect: The sum of FlipDiffArray[j] for j < Idx.
    % FlipDiffArray: The mutable array tracking flip differences.
    % TotalFlips: The count of flips performed so far.
    min_k_bit_flips_helper(Nums, K, N, 0, 0, FlipDiffArray, 0).

min_k_bit_flips_helper([], _K, _N, _Idx, _CumulativeFlipEffect, _FlipDiffArray, TotalFlips) ->
    TotalFlips;
min_k_bit_flips_helper([Num | RestNums], K, N, Idx, CumulativeFlipEffect, FlipDiffArray, TotalFlips) ->
    % 1. Calculate the current active flips at the beginning of Idx.
    % This is the cumulative effect from previous indices plus any change at Idx itself.
    CurrentFlipEffectAtIdx = array:get(Idx, FlipDiffArray),
    ActiveFlipsAtCurrentIdx = CumulativeFlipEffect + CurrentFlipEffectAtIdx,

    % 2. Determine the effective state of the current bit (Num).
    % If ActiveFlipsAtCurrentIdx is odd, the bit is effectively flipped.
    % (ActiveFlipsAtCurrentIdx band 1) is equivalent to (ActiveFlipsAtCurrentIdx mod 2).
    EffectiveBit = Num bxor (ActiveFlipsAtCurrentIdx band 1),

    if EffectiveBit == 0 ->
        % 3. The current bit is 0 (or effectively 0), so we must flip it.
        % a. Check if a K-consecutive flip can be started at Idx.
        % A flip starting at Idx affects bits up to Idx + K - 1.
        % If Idx + K > N, it means the flip would go out of bounds.
        if Idx + K > N ->
            -1; % Impossible to make all bits 1
        else
            % b. Increment the total number of flips.
            NewTotalFlips = TotalFlips + 1,

            % c. Record the end of this flip.
            % This flip starts at Idx and affects up to Idx + K - 1.
            % Its effect stops at Idx + K. So, we decrement FlipDiffArray at Idx + K.
            OldValAtEnd = array:get(Idx + K, FlipDiffArray),
            NewFlipDiffArray = array:set(Idx + K, OldValAtEnd - 1, FlipDiffArray),

            % d. Recurse for the next index.
            % The CumulativeFlipEffect for the next index (Idx + 1) will include
            % the active flips at the current index (ActiveFlipsAtCurrentIdx) plus
            % the effect of the flip we just started (+1).
            min_k_bit_flips_helper(RestNums, K, N, Idx + 1, ActiveFlipsAtCurrentIdx + 1, NewFlipDiffArray, NewTotalFlips)
        end;
    true ->
        % 3. The current bit is 1 (or effectively 1). No flip needed.
        % Recurse for the next index.
        % The CumulativeFlipEffect for the next index (Idx + 1) will be
        % the active flips at the current index (ActiveFlipsAtCurrentIdx).
        min_k_bit_flips_helper(RestNums, K, N, Idx + 1, ActiveFlipsAtCurrentIdx, FlipDiffArray, TotalFlips)
    end.