-module(solution).
-export([largestMagicSquare/1]).

create_2d_array(Rows, Cols, DefaultValue) ->
    lists:foldl(fun(R, Acc) ->
        array:set(R, array:new([{size, Cols}, {default, DefaultValue}, {fixed, true}]), Acc)
    end, array:new([{size, Rows}, {fixed, true}]), lists:seq(0, Rows - 1)).

get_2d_array(R, C, Array2D) ->
    array:get(C, array:get(R, Array2D)).

set_2d_array(R, C, Val, Array2D) ->
    RowArray = array:get(R, Array2D),
    NewRowArray = array:set(C, Val, RowArray),
    array:set(R, NewRowArray, Array2D).

grid_to_2d_array(Grid, M, N) ->
    lists:foldl(fun(R_idx, AccArray2D) ->
        RowList = lists:nth(R_idx + 1, Grid),
        RowArray = array:from_list(RowList),
        array:set(R_idx, RowArray, AccArray2D)
    end, array:new([{size, M}, {fixed, true}]), lists:seq(0, M - 1)).

precompute_prefix_sums(Grid2D, M, N) ->
    P_row_acc = create_2d_array(M, N, 0),
    P_col_acc = create_2d_array(M, N, 0),
    P_diag1_acc = create_2d_array(M, N, 0),
    P_diag2_acc = create_2d_array(M, N, 0),

    lists:foldl(fun(R, Acc1) ->
        {CurrentP_row, CurrentP_col, CurrentP_diag1, CurrentP_diag2} = Acc1,
        GridRowArray = array:get(R, Grid2D),
        lists:foldl(fun(C, Acc2) ->
            {PR, PC, PD1, PD2} = Acc2,
            Val = array:get(C, GridRowArray),

            PrevPR = if C > 0 then get_2d_array(R, C - 1, PR) else 0 end,
            NewPR = set_2d_array(R, C, Val + PrevPR, PR),

            PrevPC = if R > 0 then get_2d_array(R - 1, C, PC) else 0 end,
            NewPC = set_2d_array(R, C, Val + PrevPC, PC),

            PrevPD1 = if R > 0 and C > 0 then get_2d_array(R - 1, C - 1, PD1) else 0 end,
            NewPD1 = set_2d_array(R, C, Val + PrevPD1, PD1),

            PrevPD2 = if R > 0 and C < N - 1 then get_2d_array(R - 1, C + 1, PD2) else 0 end,
            NewPD2 = set_2d_array(R, C, Val + PrevPD2, PD2),

            {NewPR, NewPC, NewPD1, NewPD2}
        end, Acc1, lists:seq(0, N - 1))
    end, {P_row_acc, P_col_acc, P_diag1_acc, P_diag2_acc}, lists:seq(0, M - 1)).

get_row_sum(R, C_start, K, P_row) ->
    C_end = C_start + K - 1,
    Sum = get_2d_array(R, C_end, P_row),
    if C_start > 0 -> Sum - get_2d_array(R, C_start - 1, P_row);
       true -> Sum
    end.

get_col_sum(R_start, C, K, P_col) ->
    R_end = R_start + K - 1,
    Sum = get_2d_array(R_end, C, P_col),
    if R_start > 0 -> Sum - get_2d_array(R_start - 1, C, P_col);
       true -> Sum
    end.

get_diag1_sum(R_start, C_start, K, P_diag1) ->
    R_end = R_start + K - 1,
    C_end = C_start + K - 1,
    Sum = get_2d_array(R_end, C_end, P_diag1),
    if R_start > 0 and C_start > 0 -> Sum - get_2d_array(R_start - 1, C_start - 1, P_diag1);
       true -> Sum
    end.

get_diag2_sum(R_start, C_end, K, N, P_diag2) ->
    R_end = R_start + K - 1,
    Sum = get_2d_array(R_end, C_end, P_diag2),
    if R_start > 0 and C_end < N - 1 -> Sum - get_2d_array(R_start - 1, C_end + 1, P_diag2);
       true -> Sum
    end.

is_magic_square(R, C, K, M, N, P_row, P_col, P_diag1, P_diag2) ->
    TargetSum = get_row_sum(R, C, K, P_row),

    RowSumsOK = lists:all(fun(RowIdx) ->
        get_row_sum(RowIdx, C, K, P_row) == TargetSum
    end, lists:seq(R, R + K - 1)),
    if not RowSumsOK -> false;
       true ->
            ColSumsOK = lists:all(fun(ColIdx) ->
                get_col_sum(R, ColIdx, K, P_col) == TargetSum
            end, lists:seq(C, C + K - 1)),
            if not ColSumsOK -> false;
               true ->
                    MainDiagSum = get_diag1_sum(R, C, K, P_diag1),
                    if MainDiagSum /= TargetSum -> false;
                       true ->
                            AntiDiagSum = get_diag2_sum(R, C + K - 1, K, N, P_diag2),
                            if AntiDiagSum /= TargetSum -> false;
                               true -> true
                            end
                    end
            end
    end.

find_magic_square_at_k(R, C, K, M, N, P_row, P_col, P_diag1, P_diag2) when R <= M - K ->
    if C <= N - K ->
        if is_magic_square(R, C, K, M, N, P_row, P_col, P_diag1, P_diag2) ->
            true;
           true ->
            find_magic_square_at_k(R, C + 1, K, M, N, P_row, P_col, P_diag1, P_diag2)
        end;
       true ->
        find_magic_square_at_k(R + 1, 0, K, M, N, P_row, P_col, P_diag1, P_diag2)
    end;
find_magic_square_at_k(_R, _C, _K, _M, _N, _P_row, _P_col, _P_diag1, _P_diag2) ->
    false.

find_largest_k_loop(K, M, N, P_row, P_col, P_diag1, P_diag2) when K >= 1 ->
    case find_magic_square_at_k(0, 0, K, M, N, P_row, P_col, P_diag1, P_diag2) of
        true -> K;
        false -> find_largest_k_loop(K - 1, M, N, P_row, P_col, P_diag1, P_diag2)
    end;
find_largest_k_loop(0, _M, _N, _P_row, _P_col, _P_diag1, _P_diag2) ->
    1.

largestMagicSquare(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    Grid2D = grid_to_2d_array(Grid, M, N),
    {P_row, P_col, P_diag1, P_diag2} = precompute_prefix_sums(Grid2D, M, N),

    MaxPossibleK = min(M, N),

    find_largest_k_loop(MaxPossibleK, M, N, P_row, P_col, P_diag1, P_diag2).