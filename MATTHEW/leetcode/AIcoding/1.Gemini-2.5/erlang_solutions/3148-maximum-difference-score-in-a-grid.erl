-module(solution).
-export([max_score/1]).

max_score(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    % Initial max_score: The minimum possible score is 0 - 10^5 = -100000.
    % So, -100001 is a safe lower bound.
    InitialMaxScore = -100001,

    % A value larger than any possible grid cell value (0 to 10^5), used as 'infinity' for minimums.
    InfinityVal = 100001,

    % Initial PrevMinPrefixRow for the first iteration (R_idx=0).
    % Conceptually, this row is "above" the grid, so all values are InfinityVal.
    InitialPrevMinPrefixRow = lists:duplicate(N, InfinityVal),

    % The outer foldl iterates through each row of the grid.
    % State for outer foldl: {CurrentAccumulatedMaxScore, PreviousRowMinPrefixValues}
    % PreviousRowMinPrefixValues is the list of minimum prefix values calculated for the row above the current one.
    lists:foldl(
        fun(CurrentGridRow, {AccMaxScore, PrevMinPrefixRowList}) ->
            % The inner foldl iterates through each cell (column) in the CurrentGridRow.
            % State for inner foldl: {CurrentAccMaxScoreInRow, CurrentMinPrefixRowReversed, PrevMinPrefixValInCurrentRow, PrevMinPrefixRowListTail}
            %   CurrentAccMaxScoreInRow: Max score found so far in the current row processing.
            %   CurrentMinPrefixRowReversed: List of min prefix values for the current row, built in reverse.
            %   PrevMinPrefixValInCurrentRow: min_prefix_grid[R_idx][C_idx-1], the minimum prefix value from the cell to the left.
            %   PrevMinPrefixRowListTail: The remaining part of PrevMinPrefixRowList, used to get min_prefix_grid[R_idx-1][C_idx].

            {NewMaxScore, CurrentMinPrefixRowReversed, _PrevMinPrefixValInCurrentRow, _} =
                lists:foldl(
                    fun(CurrentVal, {AccMaxScoreInner, AccMinPrefixRowReversed, PrevMinPrefixValInCurrentRow, [MinValFromTop | RestPrevMinPrefixRowList]}) ->
                        % MinValForScore is the minimum value from cells (r', c') where r' <= r, c' <= c, and (r', c') != (r, c).
                        % This is equivalent to min(min_prefix_grid[r-1][c], min_prefix_grid[r][c-1]).
                        MinValForScore = min(MinValFromTop, PrevMinPrefixValInCurrentRow),

                        % Update the maximum score found so far.
                        % Only update if MinValForScore is not InfinityVal (meaning there's a valid previous cell).
                        UpdatedMaxScore = case MinValForScore of
                                              InfinityVal -> AccMaxScoreInner;
                                              _ -> max(AccMaxScoreInner, CurrentVal - MinValForScore)
                                          end,

                        % Calculate the min prefix value for the current cell (r, c).
                        % min_prefix_grid[r][c] = min(grid[r][c], min_prefix_grid[r-1][c], min_prefix_grid[r][c-1])
                        CurrentMinForDp = min(CurrentVal, MinValForScore),

                        % Update the inner foldl state.
                        {UpdatedMaxScore, [CurrentMinForDp | AccMinPrefixRowReversed], CurrentMinForDp, RestPrevMinPrefixRowList}
                    end,
                    {AccMaxScore, [], InfinityVal, PrevMinPrefixRowList}, % Initial state for inner foldl
                    CurrentGridRow % Iterate over elements of CurrentGridRow directly
                ),

            % Reverse the list of min prefix values for the current row to get it in correct order for the next iteration's PrevMinPrefixRowList.
            CurrentMinPrefixRow = lists:reverse(CurrentMinPrefixRowReversed),

            % Return the updated max score and the current row's min prefix values for the next outer foldl iteration.
            {NewMaxScore, CurrentMinPrefixRow}
        end,
        {InitialMaxScore, InitialPrevMinPrefixRow},
        Grid % Iterate over rows of Grid directly
    ) |> fun({FinalMaxScore, _}) -> FinalMaxScore end. % Extract the final max score from the final tuple