-module(solution).
-export([paths_with_sum_divisible_by_k/2]).

paths_with_sum_divisible_by_k(Grid, K) ->
    M = length(Grid),
    N = length(hd(Grid)),
    MOD = 1_000_000_007,

    % Helper function to get a value from the grid (0-indexed R, C)
    get_grid_val(Grid, R, C) ->
        lists:nth(C + 1, lists:nth(R + 1, Grid)).

    % Initialize DP table: gb_array of M rows, each row is gb_array of N cells,
    % each cell is gb_array of K counts (for remainders 0 to K-1).
    % All initial counts are 0.
    DP_Table_Initial = gb_array:new(M, {default, gb_array:new(N, {default, gb_array:new(K, {default, 0})})}),

    % Base case: (0, 0)
    Val00 = get_grid_val(Grid, 0, 0),
    Rem00 = Val00 rem K,

    % Get the gb_array for row 0
    Row0_Initial = gb_array:get(0, DP_Table_Initial),
    % Get the gb_array for cell (0,0)
    Cell00_Initial = gb_array:get(0, Row0_Initial),
    % Set the count for Rem00 to 1 in cell (0,0)
    Cell00_Updated = gb_array:set(Rem00, 1, Cell00_Initial),
    % Update row 0 with the updated cell (0,0)
    Row0_Updated = gb_array:set(0, Cell00_Updated, Row0_Initial),
    % Update the DP table with the updated row 0
    DP_Table_With_Base = gb_array:set(0, Row0_Updated, DP_Table_Initial),

    % Iterate through the grid to fill the DP table
    FinalDP_Table =
        lists:foldl(
            fun(R, AccDP) -> % AccDP is the current state of the DP table
                lists:foldl(
                    fun(C, AccDP_Inner) -> % AccDP_Inner is the current state of the DP table for this row
                        % Skip (0,0) as its base case is already handled
                        if R == 0 andalso C == 0 ->
                            AccDP_Inner;
                        true ->
                            Val = get_grid_val(Grid, R, C),
                            ValModK = Val rem K, % The remainder of the current cell's value

                            % Get the current row R from AccDP_Inner
                            CurrentRow = gb_array:get(R, AccDP_Inner),
                            % Get the gb_array of counts for cell (R, C) (initially all zeros)
                            CurrentCellCounts = gb_array:get(C, CurrentRow),

                            % Calculate new counts for Cell(R,C) by iterating through all possible previous remainders
                            NewCellCounts =
                                lists:foldl(
                                    fun(PrevRem, TempCounts) ->
                                        CountFromUp = 0,
                                        CountFromLeft = 0,

                                        % Paths coming from (R-1, C)
                                        if R > 0 ->
                                            PrevRowUp = gb_array:get(R-1, AccDP_Inner),
                                            PrevCellUpCounts = gb_array:get(C, PrevRowUp),
                                            CountFromUp = gb_array:get(PrevRem, PrevCellUpCounts);
                                        true -> ok
                                        end,

                                        % Paths coming from (R, C-1)
                                        if C > 0 ->
                                            PrevRowLeft = gb_array:get(R, AccDP_Inner), % This is the current row being built
                                            PrevCellLeftCounts = gb_array:get(C-1, PrevRowLeft),
                                            CountFromLeft = gb_array:get(PrevRem, PrevCellLeftCounts);
                                        true -> ok
                                        end,

                                        TotalCountForPrevRem = (CountFromUp + CountFromLeft) rem MOD,

                                        if TotalCountForPrevRem > 0 ->
                                            NewRem = (PrevRem + ValModK) rem K,
                                            CurrentValAtNewRem = gb_array:get(NewRem, TempCounts),
                                            UpdatedValAtNewRem = (CurrentValAtNewRem + TotalCountForPrevRem) rem MOD,
                                            gb_array:set(NewRem, UpdatedValAtNewRem, TempCounts);
                                        true -> TempCounts
                                        end
                                    end,
                                    CurrentCellCounts, % Initial accumulator for TempCounts (array of K zeros)
                                    lists:seq(0, K-1) % Iterate through all possible previous remainders
                                ),
                            % Update the DP table with the new counts for (R, C)
                            UpdatedRowR = gb_array:set(C, NewCellCounts, CurrentRow),
                            gb_array:set(R, UpdatedRowR, AccDP_Inner)
                        end
                    end,
                    AccDP, % AccDP is passed as the initial state for the inner fold (C loop)
                    lists:seq(0, N-1)
                )
            end,
            DP_Table_With_Base, % Initial state for the outer fold (R loop)
            lists:seq(0, M-1)
        ),

    % The final answer is the count of paths to (M-1, N-1) with a sum remainder of 0
    FinalRow = gb_array:get(M-1, FinalDP_Table),
    FinalCell = gb_array:get(N-1, FinalRow),
    gb_array:get(0, FinalCell).