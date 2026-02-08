-module(solution).
-export([numberOfArithmeticSlices/1]).

numberOfArithmeticSlices(Nums) ->
    N = length(Nums),
    case N < 3 of
        true -> 0;
        false ->
            % dp[i] will be a map where keys are common differences and values are
            % the counts of arithmetic subsequences of length >= 2 ending at index i
            % with that common difference.
            % Initialize Dp as an array of N empty maps.
            Dp = array:new(N, []),

            % Convert list to array for O(1) access
            NumsArray = array:from_list(Nums),

            % Start the main calculation loop
            calculate_slices(0, N, NumsArray, Dp, 0)
    end.

calculate_slices(I, N, NumsArray, Dp, AccTotalSlices) when I < N ->
    % Get the map corresponding to Dp[I]. This will be updated by calculate_for_j.
    CurrentDpI = array:get(I, Dp),
    NumI = array:get(I, NumsArray),

    % Iterate j from 0 to I-1, updating CurrentDpI and AccTotalSlices
    {NewDpI, NewAccTotalSlices} = calculate_for_j(0, I, NumsArray, Dp, NumI, CurrentDpI, AccTotalSlices),

    % Update the Dp array with the final map for Dp[I]
    UpdatedDp = array:set(I, NewDpI, Dp),

    % Recurse for the next index I
    calculate_slices(I + 1, N, NumsArray, UpdatedDp, NewAccTotalSlices);
calculate_slices(_I, _N, _NumsArray, _Dp, AccTotalSlices) ->
    AccTotalSlices.

calculate_for_j(J, I, NumsArray, Dp, NumI, CurrentDpI, AccTotalSlices) when J < I ->
    NumJ = array:get(J, NumsArray),
    Diff = NumI - NumJ,

    % Get the map for Dp[J] (read-only)
    DpJ = array:get(J, Dp),

    % Count of arithmetic subsequences of length >= 2 ending at J with this Diff
    CountJDiff = maps:get(Diff, DpJ, 0),

    % Add CountJDiff to total_slices. These are subsequences of length >= 3
    % (formed by appending NumI to the CountJDiff subsequences ending at J).
    NewAccTotalSlices = AccTotalSlices + CountJDiff,

    % Update CurrentDpI map for the current Diff:
    % The value for CurrentDpI[Diff] is the sum of:
    % 1. Existing count for Diff in CurrentDpI
    % 2. CountJDiff (subsequences ending at J with Diff, extended by NumI)
    % 3. 1 (for the new length 2 subsequence (NumJ, NumI))
    CurrentCountIDiff = maps:get(Diff, CurrentDpI, 0),
    UpdatedCountIDiff = CurrentCountIDiff + CountJDiff + 1,
    NewCurrentDpI = maps:put(Diff, UpdatedCountIDiff, CurrentDpI),

    % Recurse for the next index J
    calculate_for_j(J + 1, I, NumsArray, Dp, NumI, NewCurrentDpI, NewAccTotalSlices);
calculate_for_j(_J, _I, _NumsArray, _Dp, _NumI, CurrentDpI, AccTotalSlices) ->
    {CurrentDpI, AccTotalSlices}.