-module(solution).
-export([max_product_path/1]).

max_product_path(Matrix) ->
    M = length(Matrix),
    N = length(hd(Matrix)),
    MOD = 1000000007,

    % Helper function to get value from Matrix at (I, J) (0-indexed)
    get_matrix_val(I, J, Mat) ->
        lists:nth(J + 1, lists:nth(I + 1, Mat)).

    % Helper function to get DP state at (I, J) (0-indexed)
    get_dp_val(I, J, DpTable) ->
        lists:nth(J + 1, lists:nth(I + 1, DpTable)).

    % Helper function to update DP state at (I, J) (0-indexed)
    % Returns a new DpTable with the updated value.
    update_dp_val(I, J, NewVal, DpTable) ->
        CurrentRow = lists:nth(I + 1, DpTable),
        UpdatedRow = lists:replace_at(J, NewVal, CurrentRow),
        lists:replace_at(I, UpdatedRow, DpTable).

    % Create an M x N list of lists of placeholder tuples {0, 0}.
    % This will be conceptually updated by creating new lists in each step.
    DP_initial = lists:duplicate(M, lists:duplicate(N, {0, 0})),

    % Base case: dp[0][0]
    Val00 = get_matrix_val(0, 0, Matrix),
    DP_after_00 = update_dp_val(0, 0, {Val00, Val00}, DP_initial),

    % Fill first row (i=0), starting from j=1
    DP_after_row0 = lists:foldl(
        fun(J, AccDP) ->
            CurrentVal = get_matrix_val(0, J, Matrix),
            {PrevMin, PrevMax} = get_dp_val(0, J-1, AccDP),

            {NewMin, NewMax} = if
                CurrentVal >= 0 -> {PrevMin * CurrentVal, PrevMax * CurrentVal};
                true -> {PrevMax * CurrentVal, PrevMin * CurrentVal}
            end,
            update_dp_val(0, J, {NewMin, NewMax}, AccDP)
        end,
        DP_after_00,
        lists:seq(1, N-1)
    ),

    % Fill first column (j=0), starting from i=1
    DP_after_col0 = lists:foldl(
        fun(I, AccDP) ->
            CurrentVal = get_matrix_val(I, 0, Matrix),
            {PrevMin, PrevMax} = get_dp_val(I-1, 0, AccDP),

            {NewMin, NewMax} = if
                CurrentVal >= 0 -> {PrevMin * CurrentVal, PrevMax * CurrentVal};
                true -> {PrevMax * CurrentVal, PrevMin * CurrentVal}
            end,
            update_dp_val(I, 0, {NewMin, NewMax}, AccDP)
        end,
        DP_after_row0,
        lists:seq(1, M-1)
    ),

    % Fill the rest of the DP table (i > 0, j > 0)
    FinalDP = lists:foldl(
        fun(I, AccDP_I_Minus_1) -> % AccDP_I_Minus_1 is the DP table after row I-1 is fully processed
            lists:foldl(
                fun(J, AccDP_J_Minus_1) -> % AccDP_J_Minus_1 is the DP table after cell (I, J-1) is processed
                    CurrentVal = get_matrix_val(I, J, Matrix),

                    {UpMin, UpMax} = get_dp_val(I-1, J, AccDP_J_Minus_1), % From cell above
                    {LeftMin, LeftMax} = get_dp_val(I, J-1, AccDP_J_Minus_1), % From cell to the left

                    {MinFromUp, MaxFromUp} = if
                        CurrentVal >= 0 -> {UpMin * CurrentVal, UpMax * CurrentVal};
                        true -> {UpMax * CurrentVal, UpMin * CurrentVal}
                    end,

                    {MinFromLeft, MaxFromLeft} = if
                        CurrentVal >= 0 -> {LeftMin * CurrentVal, LeftMax * CurrentVal};
                        true -> {LeftMax * CurrentVal, LeftMin * CurrentVal}
                    end,

                    MinProd = min(MinFromUp, MinFromLeft),
                    MaxProd = max(MaxFromUp, MaxFromLeft),

                    update_dp_val(I, J, {MinProd, MaxProd}, AccDP_J_Minus_1)
                end,
                AccDP_I_Minus_1,
                lists:seq(1, N-1)
            )
        end,
        DP_after_col0,
        lists:seq(1, M-1)
    ),

    % The final result is the maximum product at the bottom-right cell (M-1, N-1)
    {_FinalMin, FinalMax} = get_dp_val(M-1, N-1, FinalDP),

    if
        FinalMax < 0 -> -1; % If the maximum product is negative, return -1
        true -> FinalMax rem MOD % Otherwise, return the maximum product modulo 10^9 + 7
    end.