-module(solution).
-export([threeEqualParts/1]).

threeEqualParts(A) ->
    N = length(A),
    OnesIndices = find_ones_indices(A),
    TotalOnes = length(OnesIndices),

    if TotalOnes == 0 ->
        [0, 2];
    TotalOnes rem 3 /= 0 ->
        [-1, -1];
    true ->
        OnesPerPart = TotalOnes div 3,

        % 1-indexed access for lists:nth
        P1StartOneIdx = lists:nth(1, OnesIndices),
        P1EndOneIdx = lists:nth(OnesPerPart, OnesIndices),
        P2StartOneIdx = lists:nth(OnesPerPart + 1, OnesIndices),
        P2EndOneIdx = lists:nth(2 * OnesPerPart, OnesIndices),
        P3StartOneIdx = lists:nth(2 * OnesPerPart + 1, OnesIndices),
        P3EndOneIdx = lists:nth(3 * OnesPerPart, OnesIndices),

        TrailingZerosCount = N - 1 - P3EndOneIdx,

        I = P1EndOneIdx + TrailingZerosCount,
        J = P2EndOneIdx + TrailingZerosCount + 1,

        % Check if the resulting split points I and J are valid
        % I is the end index of the first part, J is the start index of the third part.
        % Constraints: 0 <= I < J-1 < N-1
        % This implies I+1 <= J-1 and J <= N-1.
        % I+1 <= J-1 means P1EndOneIdx + TrailingZerosCount + 1 <= P2EndOneIdx + TrailingZerosCount,
        % which simplifies to P1EndOneIdx + 1 <= P2EndOneIdx. This is always true as P2EndOneIdx is the index of a later '1'.
        % So, we only need to check J <= N-1 (i.e., J is not past the end of the array).
        % If J > N-1, then the third part would be empty or start beyond the array.
        if J > N - 1 ->
            [-1, -1];
        true ->
            % Compare the "value" parts (from the first '1' of each part to its end, including trailing zeros)
            % The length of this value part is determined by the third part.
            SegmentLength = (N - 1) - P3StartOneIdx + 1,

            % lists:sublist is 1-indexed, so add 1 to 0-indexed indices
            Segment1 = lists:sublist(A, P1StartOneIdx + 1, SegmentLength),
            Segment2 = lists:sublist(A, P2StartOneIdx + 1, SegmentLength),
            Segment3 = lists:sublist(A, P3StartOneIdx + 1, SegmentLength),

            if Segment1 == Segment2 andalso Segment2 == Segment3 ->
                [I, J];
            true ->
                [-1, -1]
            end
        end
    end.

find_ones_indices(A) ->
    Indices = lists:seq(0, length(A) - 1),
    Pairs = lists:zip(Indices, A),
    Ones = lists:filter(fun({_Idx, Val}) -> Val == 1 end, Pairs),
    [Idx || {Idx, _Val} <- Ones].