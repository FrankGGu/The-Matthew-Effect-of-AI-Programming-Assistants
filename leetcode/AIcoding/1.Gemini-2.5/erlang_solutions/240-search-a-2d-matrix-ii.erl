-module(solution).
-export([searchMatrix/2]).

searchMatrix(Matrix, Target) ->
    case Matrix of
        [] -> false;
        [[]|_] -> false; % Handle matrix with empty rows
        _ ->
            % Convert each row list to a tuple for O(1) element access
            MatrixAsTuples = [list_to_tuple(Row) || Row <- Matrix],

            % Get the number of columns from the first row (assuming non-empty and consistent row lengths)
            Cols = tuple_size(hd(MatrixAsTuples)),

            % Start the search from the top-right corner of the matrix.
            % search_tuples(RemainingMatrixTuples, Target, CurrentColIdx)
            % CurrentColIdx starts at Cols - 1 (0-indexed)
            search_tuples(MatrixAsTuples, Target, Cols - 1)
    end.

search_tuples(RemainingMatrixTuples, Target, Col) ->
    if
        % Base cases:
        % 1. No more rows to search (Row index out of bounds)
        % 2. Column index out of bounds
        RemainingMatrixTuples == [] orelse Col < 0 ->
            false;
        true ->
            % Get the current row tuple (O(1) operation)
            CurrentRowTuple = hd(RemainingMatrixTuples),

            % Get the value at the current position (O(1) operation using element/2)
            CurrentVal = element(Col + 1, CurrentRowTuple), % Erlang tuples are 1-indexed for element/2

            if
                CurrentVal == Target ->
                    true; % Target found
                CurrentVal < Target ->
                    % Current value is too small.
                    % Since rows are sorted, all values to the left in this row are even smaller.
                    % Since columns are sorted, values below in this column are larger or equal.
                    % Move down to the next row to find a larger value.
                    search_tuples(tl(RemainingMatrixTuples), Target, Col);
                CurrentVal > Target ->
                    % Current value is too large.
                    % Since columns are sorted, all values below in this column are even larger.
                    % Since rows are sorted, values to the left in this row are smaller or equal.
                    % Move left to the previous column to find a smaller value.
                    search_tuples(RemainingMatrixTuples, Target, Col - 1)
            end
    end.