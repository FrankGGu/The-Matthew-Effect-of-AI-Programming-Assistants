-module(solution).
-export([tilingRectangle/2]).

tilingRectangle(M, N) ->
    % Initialize the grid (all uncovered) as a tuple of row bitmasks.
    % Each row_bitmask is an integer where the C-th bit is 1 if cell (R,C) is covered.
    InitialGrid = list_to_tuple(lists:duplicate(M, 0)), % 0 for uncovered (all bits off)

    % Call a helper function with memoization state.
    % The solve function returns {Result, UpdatedMemo}. We only need the Result.
    {Result, _FinalMemo} = solve(InitialGrid, M, N, maps:new()),
    Result.

solve(Grid, M, N, Memo) ->
    % Check memoization table for the current grid state.
    case maps:find(Grid, Memo) of
        {ok, Result} -> {Result, Memo}; % If found, return the cached result and the current memo.
        error ->
            % Find the top-leftmost uncovered cell (R, C).
            case find_uncovered(Grid, M, N) of
                {ok, R, C} ->
                    % Determine the maximum possible square size that can start at (R, C).
                    MaxSquareSize = min(M - R, N - C),

                    % Try placing squares of different sizes, starting from MaxSquareSize down to 1.
                    % We initialize the minimum squares found so far with a large number (200, as max is much less).
                    % try_sizes will return {MinSquares, UpdatedMemo}.
                    {MinSquares, UpdatedMemoFromSizes} = try_sizes(MaxSquareSize, R, C, Grid, M, N, Memo, 200),

                    % Store the computed minimum squares for the current grid state in the memoization table.
                    FinalMemo = maps:put(Grid, MinSquares, UpdatedMemoFromSizes),
                    {MinSquares, FinalMemo};

                not_found ->
                    % If no uncovered cells are found, the rectangle is fully tiled.
                    % This state requires 0 additional squares. Return 0 and the current memo.
                    {0, Memo}
            end
    end.

try_sizes(0, _R, _C, _Grid, _M, _N, Memo, CurrentMin) ->
    % Base case: If no more square sizes to try, return the best minimum found so far and the memo.
    {CurrentMin, Memo};
try_sizes(S, R, C, Grid, M, N, Memo, CurrentMin) ->
    % Check if an S x S square can be placed at (R, C) without overlapping covered cells or going out of bounds.
    case can_place(R, C, S, Grid, M, N) of
        true ->
            % If it can be placed, create a new grid state with the S x S square placed.
            NewGrid = place_square(R, C, S, Grid),

            % Recursively call solve for the new grid state.
            % This call will return the minimum squares needed for NewGrid and an updated memo.
            {NumSquares, MemoAfterSolve} = solve(NewGrid, M, N, Memo),

            % Update the overall minimum squares needed (1 for the current square + NumSquares from recursion).
            NewMin = min(CurrentMin, 1 + NumSquares),

            % Continue trying smaller square sizes, passing the updated memo and the new minimum.
            try_sizes(S - 1, R, C, Grid, M, N, MemoAfterSolve, NewMin);
        false ->
            % If the square cannot be placed, try the next smaller size without changing the grid or memo.
            try_sizes(S - 1, R, C, Grid, M, N, Memo, CurrentMin)
    end.

find_uncovered(Grid, M, N) ->
    % Start searching for an uncovered cell from (0, 0).
    find_uncovered(Grid, M, N, 0, 0).

find_uncovered(_Grid, _M, _N, R, _C) when R >= _M ->
    % Base case: If all rows have been checked, no uncovered cell found.
    not_found;
find_uncovered(Grid, M, N, R, C) ->
    % Get the bitmask for the current row.
    RowMask = element(R + 1, Grid),

    % Check cells in the current row from C onwards.
    case find_uncovered_in_row(RowMask, N, C) of
        {ok, FoundC} -> {ok, R, FoundC}; % Found an uncovered cell at (R, FoundC).
        not_found ->
            % If no uncovered cell in the current row, move to the next row (starting from column 0).
            find_uncovered(Grid, M, N, R + 1, 0)
    end.

find_uncovered_in_row(_RowMask, N, C) when C >= N ->
    % Base case: If all columns in the current row have been checked, no uncovered cell found in this row.
    not_found;
find_uncovered_in_row(RowMask, N, C) ->
    % Check if the C-th bit in RowMask is 0 (uncovered).
    case (RowMask band (1 bsl C)) of
        0 -> {ok, C}; % Cell (R, C) is uncovered.
        _ -> find_uncovered_in_row(RowMask, N, C + 1) % Move to the next column in the row.
    end.

can_place(R, C, S, Grid, M, N) ->
    % Check if the square fits within the rectangle boundaries.
    R + S =< M andalso C + S =< N andalso
    % Check if all cells within the S x S square starting at (R, C) are currently uncovered.
    check_square_uncovered(R, C, S, Grid, R).

check_square_uncovered(_R_start, _C_start, S, _Grid, R_curr) when R_curr >= _R_start + S ->
    % Base case: All rows of the square have been checked and are uncovered.
    true;
check_square_uncovered(R_start, C_start, S, Grid, R_curr) ->
    % Get the bitmask for the current row.
    RowMask = element(R_curr + 1, Grid),
    % Create a bitmask representing the S columns that the square would occupy in this row.
    % e.g., for S=3, C_start=1: ((1 bsl 3) - 1) bsl 1 = (8-1) bsl 1 = 7 bsl 1 = 14 (binary 1110)
    SquareColsMask = ((1 bsl S) - 1) bsl C_start,

    % Check if any of the bits in RowMask corresponding to SquareColsMask are already set (covered).
    case (RowMask band SquareColsMask) of
        0 ->
            % If all cells in this row segment are uncovered, check the next row of the square.
            check_square_uncovered(R_start, C_start, S, Grid, R_curr + 1);
        _ -> false % Some cell in this row segment is already covered.
    end.

place_square(R_start, C_start, S, Grid) ->
    % Create a bitmask representing the S columns that the square would occupy in each row.
    SquareColsMask = ((1 bsl S) - 1) bsl C_start,

    % Recursively update the rows of the grid to mark the square's cells as covered.
    place_square_rows_bitmask(R_start, S, Grid, R_start, SquareColsMask).

place_square_rows_bitmask(_R_start, S, Grid, R_curr, _SquareColsMask) when R_curr >= _R_start + S ->
    % Base case: All rows of the square have been updated. Return the new grid.
    Grid;
place_square_rows_bitmask(R_start, S, Grid, R_curr, SquareColsMask) ->
    % Get the original bitmask for the current row.
    OriginalRowMask = element(R_curr + 1, Grid),
    % Set the bits corresponding to the square's columns in this row (mark as covered).
    NewRowMask = OriginalRowMask bor SquareColsMask,
    % Create a new grid tuple with the updated row bitmask.
    UpdatedGrid = setelement(R_curr + 1, Grid, NewRowMask),
    % Continue to the next row of the square.
    place_square_rows_bitmask(R_start, S, UpdatedGrid, R_curr + 1, SquareColsMask).