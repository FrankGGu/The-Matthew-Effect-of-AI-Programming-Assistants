-module(solution).
-export([decodeCiphertext/2]).

decodeCiphertext(EncodedText, Rows) ->
    N = length(EncodedText),

    if N == 0 ->
        "";
       true ->
        Cols = calculate_cols(N, Rows),

        Grid = array:new({Rows, Cols}, $\s), % Initialize grid with spaces

        % Fill the grid
        FilledGrid = fill_grid(EncodedText, Rows, Cols, Grid),

        % Read the grid row by row
        DecodedChars = read_grid_row_by_row(FilledGrid, Rows, Cols),

        % Remove trailing spaces
        trim_trailing_spaces(DecodedChars)
    end.

calculate_cols(N, Rows) ->
    if N == 0 ->
        0;
       Rows == 1 -> % Special case: if only one row, cols is N
        N;
       true ->
        % Case 1: Cols <= Rows. Sum of diagonal lengths is C * (C+1) / 2.
        % Solve C^2 + C - 2N = 0 for C. C = (-1 + sqrt(1 + 8N)) / 2.
        C1_float = (math:sqrt(1 + 8.0 * N) - 1) / 2.0,
        C1_val = round(C1_float),

        % Check if C1_val is an integer and satisfies C1_val <= Rows
        if abs(C1_val - C1_float) < 1.0e-9 andalso (C1_val * (C1_val + 1) div 2 == N) andalso (C1_val =< Rows) ->
            C1_val;
           true ->
            % Case 2: Cols > Rows. Sum of diagonal lengths is (C-R) * R + R * (R+1) / 2.
            % Solve C*R - R^2 + R*(R+1)/2 = N for C.
            % C = (N + R^2 - R*(R+1)/2) / R.
            C2_float = (N + Rows*Rows - Rows*(Rows+1) div 2) / (1.0 * Rows),
            C2_val = round(C2_float),

            % Check if C2_val is an integer and satisfies C2_val > Rows
            if abs(C2_val - C2_float) < 1.0e-9 andalso (C2_val * Rows - Rows*Rows + Rows*(Rows+1) div 2 == N) andalso (C2_val > Rows) ->
                C2_val;
               true ->
                % This case should ideally not be reached for valid LeetCode inputs
                % If it is, there's an issue with the formula or problem interpretation
                error(invalid_cols_calculation)
            end
        end
    end.

fill_grid(EncodedText, Rows, Cols, Grid) ->
    CurrentGrid = Grid,
    EncodedIdx = 0, % 0-indexed for EncodedText
    fill_grid_loop(EncodedText, Rows, Cols, CurrentGrid, EncodedIdx, 0).

fill_grid_loop(EncodedText, Rows, Cols, CurrentGrid, EncodedIdx, J) ->
    if J >= Cols -> % All starting columns processed
        CurrentGrid;
       EncodedIdx >= length(EncodedText) -> % No more characters in EncodedText
        CurrentGrid;
       true ->
        % Fill current diagonal
        {UpdatedGrid, NextEncodedIdx} = fill_diagonal(EncodedText, Rows, Cols, CurrentGrid, EncodedIdx, J, 0),
        % Move to next starting column
        fill_grid_loop(EncodedText, Rows, Cols, UpdatedGrid, NextEncodedIdx, J + 1)
    end.

fill_diagonal(EncodedText, Rows, Cols, CurrentGrid, EncodedIdx, J, R) ->
    if R >= Rows -> % Diagonal finished (vertically)
        {CurrentGrid, EncodedIdx};
       EncodedIdx >= length(EncodedText) -> % No more characters in EncodedText
        {CurrentGrid, EncodedIdx};
       true ->
        C_diag = J + R,
        if C_diag >= Cols -> % Diagonal goes out of bounds horizontally
            {CurrentGrid, EncodedIdx};
           true ->
            Char = lists:nth(EncodedIdx + 1, EncodedText), % lists:nth is 1-indexed
            UpdatedGrid = array:set({R, C_diag}, Char, CurrentGrid),
            fill_diagonal(EncodedText, Rows, Cols, UpdatedGrid, EncodedIdx + 1, J, R + 1)
        end
    end.

read_grid_row_by_row(Grid, Rows, Cols) ->
    lists:foldl(fun(R, Acc) ->
                    RowChars = lists:foldl(fun(C, RowAcc) ->
                                                [array:get({R, C}, Grid) | RowAcc]
                                        end, [], lists:seq(0, Cols - 1)),
                    Acc ++ lists:reverse(RowChars)
            end, [], lists:seq(0, Rows - 1)).

trim_trailing_spaces(Chars) ->
    lists:dropwhile(fun(C) -> C == $\s end, lists:reverse(Chars)).