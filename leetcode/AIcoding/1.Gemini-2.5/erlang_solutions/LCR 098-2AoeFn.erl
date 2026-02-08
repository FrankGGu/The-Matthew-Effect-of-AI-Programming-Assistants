-module(solution).
-export([unique_paths/2]).

unique_paths(M, N) when M =< 0; N =< 0 ->
    0;
unique_paths(M, N) ->
    % Initialize the first row (dp[0][j] = 1 for all j).
    % This row will serve as the 'PrevRow' for the first iteration.
    CurrentRow = lists:duplicate(N, 1),

    % Iterate M-1 times to calculate rows from 1 to M-1.
    % The accumulator for this foldl is the 'PrevRow' (the row calculated in the previous iteration).
    FinalRow = lists:foldl(
        fun(_, PrevRow) ->
            % Calculate the 'NewRow' based on 'PrevRow'.
            % The first element of the new row (dp[i][0]) is always 1.
            NewRowTailReversed = calculate_row_tail_reversed(PrevRow),
            [1 | lists:reverse(NewRowTailReversed)]
        end,
        CurrentRow, % Start with the first row (all ones)
        lists:seq(2, M) % Iterate M-1 times (for row indices 1 to M-1)
    ),

    % The result is the last element of the FinalRow, which corresponds to dp[M-1][N-1].
    lists:last(FinalRow).

calculate_row_tail_reversed(PrevRow) ->
    % PrevRow = [P0, P1, P2, ..., PN-1]
    % We need to calculate [N1, N2, ..., NN-1] where N0 (the first element of the current row) is 1.
    % The recurrence relation is Nj = N(j-1) + Pj.

    % The foldl iterates over [P1, P2, ..., PN-1] (which is tl(PrevRow)).
    % The accumulator is a tuple {CurrentRowPrevVal, AccTailReversed}.
    % CurrentRowPrevVal starts as N0 (which is 1).
    % AccTailReversed starts as an empty list and elements are prepended for efficiency.

    {_, TailReversed} = lists:foldl(
        fun(PrevRowColVal, {CurrentRowPrevVal, AccTailReversed}) ->
            NewColVal = CurrentRowPrevVal + PrevRowColVal,
            {NewColVal, [NewColVal | AccTailReversed]} % Prepending to list is O(1)
        end,
        {1, []}, % Initial state: CurrentRowPrevVal = NewRow[0] = 1, AccTailReversed = []
        tl(PrevRow) % Iterate over elements P1, P2, ...
    ),
    TailReversed.