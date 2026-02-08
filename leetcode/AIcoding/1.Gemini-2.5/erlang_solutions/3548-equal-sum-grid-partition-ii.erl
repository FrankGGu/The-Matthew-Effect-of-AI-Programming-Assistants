-module(solution).
-export([equal_sum_grid_partition_ii/1]).

-include_lib("stdlib/include/array.hrl").

equal_sum_grid_partition_ii(GridList) ->
    M = length(GridList),
    N = length(hd(GridList)),

    % Handle edge cases where grid is too small for 4 non-empty regions
    % Requires at least 3 rows and 3 columns for 2 horizontal and 2 vertical cuts
    % (e.g., r1=1, r2=2, c1=1, c2=2)
    if
        M < 3; N < 3 ->
            false;
        true ->
            % Convert GridList to array of arrays for O(1) access
            GridArray = array:from_list(lists:map(fun array:from_list/1, GridList)),

            PrefixSumsArray = calculate_prefix_sums_array(GridArray, M, N),

            TotalSum = get_sum_from_prefix_array(PrefixSumsArray, 0, 0, M-1, N-1),

            case TotalSum rem 4 of
                0 ->
                    TargetSum = TotalSum div 4,
                    check_partitions_array(M, N, PrefixSumsArray, TargetSum);
                _ ->
                    false
            end
    end.

calculate_prefix_sums_array(GridArray, M, N) ->
    % P[r][c] stores sum of grid[0][0] to grid[r-1][c-1]
    % P will be (M+1) x (N+1)
    P0 = array:new([{size, N + 1}, {fixed, true}, {default, 0}]), % First row of prefix sums (all zeros)

    % AccPrefixRows will be a list of array:array() rows.
    % We build it by prepending new rows, so it will be [P[RIdx], P[RIdx-1], ..., P[0]]
    PrefixRowsReversed = lists:foldl(
        fun(RIdx, AccPrefixRows) -> % AccPrefixRows is [P[RIdx] | P[RIdx-1] | ... | P[0]]
            % PrevPrefixRow is P[RIdx] (an array)
            PrevPrefixRow = hd(AccPrefixRows),
            % GridRowArray is grid[RIdx] (an array)
            GridRowArray = array:get(RIdx, GridArray), % O(1) access

            % Build CurrentPrefixRow (P[RIdx+1]) as an array
            % It starts with 0 (P[RIdx+1][0])
            CurrentPrefixRow = array:new([{size, N + 1}, {fixed, true}, {default, 0}]),

            % Iterate CIdx from 0 to N-1
            % PrevColSum is P[RIdx+1][CIdx]
            {FinalCurrentPrefixRow, _} = lists:foldl(
                fun(CIdx, {CurrentArray, PrevColSum}) ->
                    GridVal = array:get(CIdx, GridRowArray), % grid[RIdx][CIdx]
                    PrevRowSumVal = array:get(CIdx + 1, PrevPrefixRow), % P[RIdx][CIdx+1]
                    PrevDiagSumVal = array:get(CIdx, PrevPrefixRow), % P[RIdx][CIdx]

                    NewSum = GridVal + PrevColSum + PrevRowSumVal - PrevDiagSumVal,
                    NewArray = array:set(CIdx + 1, NewSum, CurrentArray),
                    {NewArray, NewSum}
                end,
                {CurrentPrefixRow, 0}, % Initial CurrentArray, PrevColSum is P[RIdx+1][0]
                lists:seq(0, N - 1)
            ),
            [FinalCurrentPrefixRow | AccPrefixRows] % Prepend the new row P[RIdx+1]
        end,
        [P0], % Initial AccPrefixRows: [P[0]]
        lists:seq(0, M - 1) % RIdx from 0 to M-1
    ),
    % Reverse to get [P[0], P[1], ..., P[M]]
    array:from_list(lists:reverse(PrefixRowsReversed)).

get_sum_from_prefix_array(PrefixSumsArray, R1, C1, R2, C2) ->
    % PrefixSumsArray[i][j] stores sum up to (i-1, j-1)
    % So, we need to access PrefixSumsArray at (R2+1, C2+1), (R1, C2+1), (R2+1, C1), (R1, C1)
    ValR2C2 = get_val_array(PrefixSumsArray, R2 + 1, C2 + 1),
    ValR1C2 = get_val_array(PrefixSumsArray, R1, C2 + 1),
    ValR2C1 = get_val_array(PrefixSumsArray, R2 + 1, C1),
    ValR1C1 = get_val_array(PrefixSumsArray, R1, C1),
    ValR2C2 - ValR1C2 - ValR2C1 + ValR1C1.

get_val_array(MatrixArray, R, C) ->
    RowArray = array:get(R, MatrixArray),
    array:get(C, RowArray).

check_partitions_array(M, N, PrefixSumsArray, TargetSum) ->
    % Iterate over possible cut positions for r1, r2, c1, c2
    % 0 < r1 < r2 < M
    % 0 < c1 < c2 < N
    % Each region must be non-empty, so at least 1x1.
    % r1 ranges from 1 to M-3
    % r2 ranges from r1+1 to M-2
    % c1 ranges from 1 to N-3
    % c2 ranges from c1+1 to N-2
    check_r1_array(1, M - 3, M, N, PrefixSumsArray, TargetSum).

check_r1_array(R1, MaxR1, M, N, PrefixSumsArray, TargetSum) when R1 =< MaxR1 ->
    % R1 is the row index *after* the first horizontal cut.
    % Region 1 & 2 use rows 0 to R1-1.
    % Region 3 & 4 use rows R2 to M-1.
    % The middle horizontal strip uses rows R1 to R2-1.
    case check_r2_array(R1 + 1, M - 2, R1, M, N, PrefixSumsArray, TargetSum) of
        true -> true;
        false -> check_r1_array(R1 + 1, MaxR1, M, N, PrefixSumsArray, TargetSum)
    end;
check_r1_array(_, _, _, _, _, _) ->
    false.

check_r2_array(R2, MaxR2, R1, M, N, PrefixSumsArray, TargetSum) when R2 =< MaxR2 ->
    case check_c1_array(1, N - 3, R1, R2, M, N, PrefixSumsArray, TargetSum) of
        true -> true;
        false -> check_r2_array(R2 + 1, MaxR2, R1, M, N, PrefixSumsArray, TargetSum)
    end;
check_r2_array(_, _, _, _, _, _, _) ->
    false.

check_c1_array(C1, MaxC1, R1, R2, M, N, PrefixSumsArray, TargetSum) when C1 =< MaxC1 ->
    % C1 is the column index *after* the first vertical cut.
    % Region 1 & 3 use cols 0 to C1-1.
    % Region 2 & 4 use cols C2 to N-1.
    % The middle vertical strip uses cols C1 to C2-1.
    case check_c2_array(C1 + 1, N - 2, R1, R2, C1, M, N, PrefixSumsArray, TargetSum) of
        true -> true;
        false -> check_c1_array(C1 + 1, MaxC1, R1, R2, M, N, PrefixSumsArray, TargetSum)
    end;
check_c1_array(_, _, _, _, _, _, _, _) ->
    false.

check_c2_array(C2, MaxC2, R1, R2, C1, M, N, PrefixSumsArray, TargetSum) when C2 =< MaxC2 ->
    Sum1 = get_sum_from_prefix_array(PrefixSumsArray, 0, 0, R1 - 1, C1 - 1),
    Sum2 = get_sum_from_prefix_array(PrefixSumsArray, 0, C2, R1 - 1, N - 1),
    Sum3 = get_sum_from_prefix_array(PrefixSumsArray, R2, 0, M - 1, C1 - 1),
    Sum4 = get_sum_from_prefix_array(PrefixSumsArray, R2, C2, M - 1, N - 1),

    if
        Sum1 == TargetSum andalso
        Sum2 == TargetSum andalso
        Sum3 == TargetSum andalso
        Sum4 == TargetSum ->
            true;
        true ->
            check_c2_array(C2 + 1, MaxC2, R1, R2, C1, M, N, PrefixSumsArray, TargetSum)
    end;
check_c2_array(_, _, _, _, _, _, _, _) ->
    false.