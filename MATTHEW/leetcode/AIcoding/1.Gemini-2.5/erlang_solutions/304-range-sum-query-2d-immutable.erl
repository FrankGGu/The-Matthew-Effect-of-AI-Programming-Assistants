-module(num_matrix).
-export([new/1, sum_region/5]).

new(Matrix) ->
    Rows = length(Matrix),
    Cols = if Rows > 0 -> length(hd(Matrix));
              true -> 0
           end,

    %% Create an array of arrays, DP, of size (Rows+1) x (Cols+1).
    %% Initialize all elements to 0.
    %% DP is an array where each element is another array (representing a row).
    DP = array:new([{size, Rows + 1}, {fixed, true}]),
    DP_init = lists:foldl(fun(R_idx, AccDP) ->
                              RowArray = array:new([{size, Cols + 1}, {default, 0}, {fixed, true}]),
                              array:set(R_idx, RowArray, AccDP)
                          end, DP, lists:seq(0, Rows)),

    %% Compute prefix sums
    %% Iterate through the original matrix (0-indexed r, c)
    %% and update DP (1-indexed r+1, c+1)
    lists:foldl(fun(R_idx, AccDP) ->
                    MatrixRow = lists:nth(R_idx + 1, Matrix), % Get 0-indexed matrix row (Erlang lists are 1-based)
                    PrevDPRow = array:get(R_idx, AccDP),      % DP row 'r' (0-indexed array access)
                    CurrentDPRow = array:get(R_idx + 1, AccDP), % DP row 'r+1', to be updated

                    NewCurrentDPRow = lists:foldl(fun(C_idx, AccCurrentDPRow) ->
                                                      Val = lists:nth(C_idx + 1, MatrixRow), % Get 0-indexed matrix value
                                                      Top = array:get(C_idx + 1, PrevDPRow), % DP[r][c+1]
                                                      Left = array:get(C_idx, AccCurrentDPRow), % DP[r+1][c] (from current row being built)
                                                      TopLeft = array:get(C_idx, PrevDPRow), % DP[r][c]

                                                      Sum = Val + Top + Left - TopLeft,
                                                      array:set(C_idx + 1, Sum, AccCurrentDPRow)
                                                  end, CurrentDPRow, lists:seq(0, Cols - 1)),
                    array:set(R_idx + 1, NewCurrentDPRow, AccDP)
                end, DP_init, lists:seq(0, Rows - 1)).

sum_region(DP, Row1, Col1, Row2, Col2) ->
    %% DP[i][j] stores sum of rectangle from (0,0) to (i-1, j-1)
    %% The sum of the rectangle (row1, col1) to (row2, col2) is:
    %% DP[row2+1][col2+1] - DP[row1][col2+1] - DP[row2+1][col1] + DP[row1][col1]

    Val_R2C2 = array:get(Col2 + 1, array:get(Row2 + 1, DP)),
    Val_R1C2 = array:get(Col2 + 1, array:get(Row1, DP)),
    Val_R2C1 = array:get(Col1, array:get(Row2 + 1, DP)),
    Val_R1C1 = array:get(Col1, array:get(Row1, DP)),

    Val_R2C2 - Val_R1C2 - Val_R2C1 + Val_R1C1.