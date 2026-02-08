-module(solution).
-export([min_path_sum/1]).

min_path_sum(Grid) ->
    Rows = length(Grid),
    Cols = length(hd(Grid)),

    % DPTableReversed will be a list of lists.
    % The outer list is built in reverse order: [DP_Row_M-1, ..., DP_Row_0]
    % Each inner list (DP row) is also built in reverse order: [DP_i_N-1, ..., DP_i_0]
    DPTableReversed = build_dp_table_reversed(Grid, 0, Rows, Cols, [], []).

    % The final result is DP[M-1][N-1], which corresponds to the head of the head
    % of the DPTableReversed (since both rows and elements within rows are reversed).
    hd(hd(DPTableReversed)).

build_dp_table_reversed([], _RowIndex, _Rows, _Cols, AccDPTableReversed, _PrevDPRowNormal) ->
    AccDPTableReversed;
build_dp_table_reversed([CurrentGridRow | RestGrid], RowIndex, Rows, Cols, AccDPTableReversed, PrevDPRowNormal) ->
    % CurrentGridRow: [G_i_0, G_i_1, ..., G_i_N-1]
    % PrevDPRowNormal: [DP_i-1_0, DP_i-1_1, ..., DP_i-1_N-1]

    % CurrentDPRowReversed will be [DP_i_N-1, ..., DP_i_0]
    CurrentDPRowReversed = build_dp_row_reversed(CurrentGridRow, PrevDPRowNormal, RowIndex, 0, []).

    % For the next iteration, the 'PrevDPRowNormal' will be the current row,
    % so we reverse CurrentDPRowReversed once (O(N) operation).
    NextPrevDPRowNormal = lists:reverse(CurrentDPRowReversed).

    % Prepend the current DP row (reversed) to the accumulated DP table (O(1)).
    build_dp_table_reversed(RestGrid, RowIndex + 1, Rows, Cols, [CurrentDPRowReversed | AccDPTableReversed], NextPrevDPRowNormal).

build_dp_row_reversed([], _PrevDPRowNormalTail, _RowIndex, _ColIndex, AccCurrentDPRowReversed) ->
    AccCurrentDPRowReversed;
build_dp_row_reversed([GridVal | RestGridRow], PrevDPRowNormalTail, RowIndex, ColIndex, AccCurrentDPRowReversed) ->
    % GridVal is Grid[RowIndex][ColIndex]

    Value = calculate_dp_value_optimized(GridVal, AccCurrentDPRowReversed, PrevDPRowNormalTail, RowIndex, ColIndex),

    % Prepend the calculated value to the current DP row (O(1)).
    % Move to the next element in the grid row and the next element in the previous DP row.
    build_dp_row_reversed(RestGridRow, tl_or_empty(PrevDPRowNormalTail), RowIndex, ColIndex + 1, [Value | AccCurrentDPRowReversed]).

calculate_dp_value_optimized(GridVal, CurrentDPRowAccReversed, PrevDPRowNormalTail, RowIndex, ColIndex) ->
    case {RowIndex, ColIndex} of
        {0, 0} -> GridVal; % Base case: top-left corner
        {0, _} -> GridVal + hd(CurrentDPRowAccReversed); % First row: only can come from left
        {_, 0} -> GridVal + hd(PrevDPRowNormalTail); % First column: only can come from above
        {_, _} -> GridVal + min(hd(CurrentDPRowAccReversed), hd(PrevDPRowNormalTail)) % General case
    end.

tl_or_empty([]) -> [];
tl_or_empty(L) -> tl(L).