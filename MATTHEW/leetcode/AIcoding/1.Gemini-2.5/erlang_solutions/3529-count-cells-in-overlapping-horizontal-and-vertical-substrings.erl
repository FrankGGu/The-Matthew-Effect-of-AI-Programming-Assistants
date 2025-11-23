-module(solution).
-export([count_cells/2]).

count_cells(GridList, S) ->
    M = length(GridList),
    N = length(hd(GridList)), % Assumes GridList is not empty and rows have consistent length
    LenS = length(S),

    % Handle edge cases for string length
    if
        LenS == 0 -> 0; % An empty string cannot be a starting point in this context.
        LenS > M andalso LenS > N -> 0; % If S is longer than both dimensions, it's impossible to form.
        true ->
            % Convert GridList to an array of arrays for efficient O(1) access to grid cells.
            GridArray = array:from_list([array:from_list(Row) || Row <- GridList]),
            count_cells_recursive(0, 0, M, N, LenS, GridArray, S, 0)
    end.

count_cells_recursive(R, C, M, N, LenS, GridArray, S, Acc) ->
    if
        R >= M -> Acc; % All rows processed, return accumulated count.
        C >= N -> count_cells_recursive(R + 1, 0, M, N, LenS, GridArray, S, Acc); % Move to next row, reset column.
        true ->
            % Get the current row array and character at (R, C).
            CurrentRowArray = array:get(R, GridArray),
            CurrentChar = array:get(C, CurrentRowArray),

            if
                CurrentChar == hd(S) -> % Check if the current character matches the first character of S.
                    % If it matches, check all four directions (horizontal right/left, vertical down/up).
                    IsStart = check_cell(R, C, M, N, LenS, GridArray, CurrentRowArray, S),
                    NewAcc = if IsStart -> Acc + 1; true -> Acc end, % Increment count if S can be formed.
                    count_cells_recursive(R, C + 1, M, N, LenS, GridArray, S, NewAcc);
                true ->
                    % If it doesn't match, move to the next column without incrementing count.
                    count_cells_recursive(R, C + 1, M, N, LenS, GridArray, S, Acc)
            end
    end.

check_cell(R, C, M, N, LenS, GridArray, CurrentRowArray, S) ->
    check_horizontal_right(C, N, LenS, CurrentRowArray, S) orelse
    check_horizontal_left(C, LenS, CurrentRowArray, S) orelse
    check_vertical_down(R, C, M, LenS, GridArray, S) orelse
    check_vertical_up(R, C, LenS, GridArray, S).

check_horizontal_right(C, N, LenS, RowArray, S) ->
    % Check if there's enough space to the right for S.
    if
        C + LenS > N -> false;
        true ->
            % Extract LenS characters starting from C.
            SubList = [array:get(ColIdx, RowArray) || ColIdx <- lists:seq(C, C + LenS - 1)],
            SubList == S
    end.

check_horizontal_left(C, LenS, RowArray, S) ->
    % Check if there's enough space to the left for S.
    if
        C - LenS + 1 < 0 -> false;
        true ->
            % Extract LenS characters ending at C (from C-LenS+1 to C).
            SubList = [array:get(ColIdx, RowArray) || ColIdx <- lists:seq(C - LenS + 1, C)],
            lists:reverse(SubList) == S % Reverse to match S (which is left-to-right).
    end.

check_vertical_down(R, C, M, LenS, GridArray, S) ->
    % Check if there's enough space downwards for S.
    if
        R + LenS > M -> false;
        true ->
            % Collect characters from column C, starting at row R for LenS rows.
            SubList = [array:get(C, array:get(RowIdx, GridArray)) || RowIdx <- lists:seq(R, R + LenS - 1)],
            SubList == S
    end.

check_vertical_up(R, C, LenS, GridArray, S) ->
    % Check if there's enough space upwards for S.
    if
        R - LenS + 1 < 0 -> false;
        true ->
            % Collect characters from column C, starting at row R upwards for LenS rows.
            SubList = [array:get(C, array:get(RowIdx, GridArray)) || RowIdx <- lists:seq(R - LenS + 1, R)],
            lists:reverse(SubList) == S % Reverse to match S (which is top-to-bottom).
    end.