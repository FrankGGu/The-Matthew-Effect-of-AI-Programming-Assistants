-module(solution).
-export([fillSpecialGrid/2]).

fillSpecialGrid(Grid, K) ->
    N = length(Grid),
    [Row0 | RestOfGrid] = Grid,
    % AccFilledGridReversed accumulates filled rows in reverse order.
    % PrevRow is the previously filled row, used for calculations.
    fill_rows(1, N, K, RestOfGrid, [Row0], Row0).

fill_rows(I, N, K, [CurrentOriginalRow | RestOfOriginalRows], AccFilledGridReversed, PrevRow) when I < N ->
    % The first element of CurrentOriginalRow (column 0) is given and does not change.
    [Val_I_0 | CurrentOriginalRowTail] = CurrentOriginalRow,

    % Prepare PrevRow for efficient iteration in fill_cols_optimized.
    % PrevRow: [P0, P1, P2, ...]
    % PrevRowTail: [P1, P2, P3, ...]
    [_ | PrevRowTail] = PrevRow,

    % Fill the rest of the row (columns 1 to N-1).
    % The initial CurrentFilledRowPrefixReversed contains Val_I_0 (grid[I][0]).
    FilledCurrentRowReversed = fill_cols_optimized(1, N, K, PrevRow, PrevRowTail, CurrentOriginalRowTail, [Val_I_0]),
    FilledCurrentRow = lists:reverse(FilledCurrentRowReversed),

    fill_rows(I+1, N, K, RestOfOriginalRows, [FilledCurrentRow | AccFilledGridReversed], FilledCurrentRow);
fill_rows(N, N, _K, [], AccFilledGridReversed, _PrevRow) ->
    % All rows processed. Reverse the accumulated list to get the correct order.
    lists:reverse(AccFilledGridReversed).

fill_cols_optimized(J, N, K, [Val_Prev_Prev | PrevRow_Rest], [Val_Prev_Curr | PrevRow_Tail_Further], [OriginalVal_I_J | CurrentOriginalRowTail], [Val_I_J_minus_1 | _] = CurrentFilledRowPrefixReversed) when J < N ->
    % Calculate the value for grid[I][J]
    CalculatedVal = K - (Val_Prev_Prev + Val_Prev_Curr + Val_I_J_minus_1),

    % If the original cell was 0, fill it with the calculated value.
    % Otherwise, keep its original value (which must be 1 and consistent).
    NewVal_I_J = if OriginalVal_I_J == 0 -> CalculatedVal;
                    true -> OriginalVal_I_J
                 end,

    % Recursively process the next column.
    fill_cols_optimized(J+1, N, K, PrevRow_Rest, PrevRow_Tail_Further, CurrentOriginalRowTail, [NewVal_I_J | CurrentFilledRowPrefixReversed]);
fill_cols_optimized(N, N, _K, _PrevRow_Rest, _PrevRow_Tail_Further, [], CurrentFilledRowPrefixReversed) ->
    % All columns in the current row processed. Return the reversed list.
    CurrentFilledRowPrefixReversed.