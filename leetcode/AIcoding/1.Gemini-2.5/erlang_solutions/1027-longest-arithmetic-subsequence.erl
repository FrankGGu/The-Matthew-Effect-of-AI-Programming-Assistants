-module(solution).
-export([longestArithmeticSubsequence/1]).

longestArithmeticSubsequence(Nums) ->
    N = length(Nums),
    % According to problem constraints, N >= 2.
    % The minimum length of an arithmetic subsequence is 2.
    % Initialize max_len to 1. It will be updated to at least 2.
    InitialMaxLen = 1,

    % Convert the input list to an array for O(1) indexed access.
    NumsArray = array:from_list(Nums),

    % DP state: an array of maps.
    % dp[i] is a map where keys are common differences and values are the lengths
    % of the longest arithmetic subsequence ending at index i with that difference.
    % Initialize DP_Array with N empty maps.
    InitialDPArray = array:new([{size, N}, {default, #{}}]),

    % Use lists:foldl to iterate through the indices I from 0 to N-1.
    % The accumulator for this fold is {CurrentMaxLen, CurrentDPArray}.
    {FinalMaxLen, _FinalDPArray} = lists:foldl(
        fun(I, {CurrentMaxLen, CurrentDPArray}) ->
            NumI = array:get(I, NumsArray),

            % For each I, we need to iterate J from 0 to I-1.
            % The accumulator for this inner fold is {InnerMaxLen, MapForI}.
            % MapForI is dp[I], which we are building up.
            % InnerMaxLen tracks the maximum length found so far within this I iteration.
            {NewMaxLenAfterJLoop, UpdatedMapForI} = lists:foldl(
                fun(J, {InnerMaxLen, MapForI}) ->
                    NumJ = array:get(J, NumsArray),
                    Diff = NumI - NumJ,

                    % Get the previous length from dp[J][Diff].
                    % If Diff is not in dp[J], it means NumJ is the start of a new
                    % subsequence with this difference, so its length is 1.
                    MapJ = array:get(J, CurrentDPArray),
                    PrevLen = maps:get(Diff, MapJ, 1),

                    % The current length is PrevLen + 1 (including NumI).
                    CurrentLen = PrevLen + 1,

                    % Update dp[I][Diff]. We take the maximum of the existing length
                    % for this diff at index I (if any) and the CurrentLen.
                    NewMapForI = maps:put(Diff, max(maps:get(Diff, MapForI, 1), CurrentLen), MapForI),

                    % Update the overall max length found.
                    {max(InnerMaxLen, CurrentLen), NewMapForI}
                end,
                {CurrentMaxLen, array:get(I, CurrentDPArray)}, % Initial state for inner fold: current overall max_len, and the map for dp[I] (initially empty)
                lists:seq(0, I - 1) % J loop range
            ),
            % After processing all J for the current I, update CurrentDPArray with the new map for dp[I].
            {NewMaxLenAfterJLoop, array:set(I, UpdatedMapForI, CurrentDPArray)}
        end,
        {InitialMaxLen, InitialDPArray},
        lists:seq(0, N - 1) % I loop range
    ),
    FinalMaxLen.

max(A, B) when A >= B -> A;
max(A, B) -> B.