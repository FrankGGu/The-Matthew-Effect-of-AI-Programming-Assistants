-module(solution).
-export([countUnguarded/1]).

-spec countUnguarded(Grid :: [[integer()]]) -> integer().
countUnguarded(Grid) ->
    M = length(Grid),
    N = length(hd(Grid)),

    GridArray = array:from_list([array:from_list(Row) || Row <- Grid]),
    GuardedArray = array:new([{size, M}, {fixed, true}, {default, array:new([{size, N}, {fixed, true}, {default, 0}])}]),

    GuardedArray1 = pass_rows_lr(M, N, GridArray, GuardedArray),
    GuardedArray2 = pass_rows_rl(M, N, GridArray, GuardedArray1),
    GuardedArray3 = pass_cols_td(M, N, GridArray, GuardedArray2),
    FinalGuardedArray = pass_cols_bu(M, N, GridArray, GuardedArray3),

    count_unguarded(M, N, GridArray, FinalGuardedArray).

get_cell(R, C, ArrayOfArrays) ->
    array:get(C, array:get(R, ArrayOfArrays)).

set_cell(R, C, Val, ArrayOfArrays) ->
    RowArray = array:get(R, ArrayOfArrays),
    NewRowArray = array:set(C, Val, RowArray),
    array:set(R, NewRowArray, ArrayOfArrays).

pass_rows_lr(M, N, GridArray, AccGuardedArray) ->
    lists:foldl(fun(R, CurrentGuardedArray) ->
        pass_row_lr_single_row(R, N, GridArray, CurrentGuardedArray)
    end, AccGuardedArray, lists:seq(0, M-1)).

pass_row_lr_single_row(R, N, GridArray, AccGuardedArray) ->
    RowGridArray = array:get(R, GridArray),
    {FinalGuardedArray, _LastGuardCol} = lists:foldl(fun(C, {CurrentGuardedArray, LastGuardCol}) ->
        CellVal = array:get(C, RowGridArray),
        if CellVal == 1 ->
            {CurrentGuardedArray, -1};
        CellVal == 2 ->
            {CurrentGuardedArray, C};
        true ->
            if LastGuardCol /= -1 ->
                NewGuardedArray = set_cell(R, C, 1, CurrentGuardedArray),
                {NewGuardedArray, LastGuardCol};
            true ->
                {CurrentGuardedArray, LastGuardCol}
            end
        end
    end, {AccGuardedArray, -1}, lists:seq(0, N-1)),
    FinalGuardedArray.

pass_rows_rl(M, N, GridArray, AccGuardedArray) ->
    lists:foldl(fun(R, CurrentGuardedArray) ->
        pass_row_rl_single_row(R, N, GridArray, CurrentGuardedArray)
    end, AccGuardedArray, lists:seq(0, M-1)).

pass_row_rl_single_row(R, N, GridArray, AccGuardedArray) ->
    RowGridArray = array:get(R, GridArray),
    {FinalGuardedArray, _LastGuardCol} = lists:foldl(fun(C, {CurrentGuardedArray, LastGuardCol}) ->
        CellVal = array:get(C, RowGridArray),
        if CellVal == 1 ->
            {CurrentGuardedArray, -1};
        CellVal == 2 ->
            {CurrentGuardedArray, C};
        true ->
            if LastGuardCol /= -1 ->
                NewGuardedArray = set_cell(R, C, 1, CurrentGuardedArray),
                {NewGuardedArray, LastGuardCol};
            true ->
                {CurrentGuardedArray, LastGuardCol}
            end
        end
    end, {AccGuardedArray, -1}, lists:seq(N-1, 0, -1)),
    FinalGuardedArray.

pass_cols_td(M, N, GridArray, AccGuardedArray) ->
    lists:foldl(fun(C, CurrentGuardedArray) ->
        pass_col_td_single_col(C, M, GridArray, CurrentGuardedArray)
    end, AccGuardedArray, lists:seq(0, N-1)).

pass_col_td_single_col(C, M, GridArray, AccGuardedArray) ->
    {FinalGuardedArray, _LastGuardRow} = lists:foldl(fun(R, {CurrentGuardedArray, LastGuardRow}) ->
        CellVal = get_cell(R, C, GridArray),
        if CellVal == 1 ->
            {CurrentGuardedArray, -1};
        CellVal == 2 ->
            {CurrentGuardedArray, R};
        true ->
            if LastGuardRow /= -1 ->
                NewGuardedArray = set_cell(R, C, 1, CurrentGuardedArray),
                {NewGuardedArray, LastGuardRow};
            true ->
                {CurrentGuardedArray, LastGuardRow}
            end
        end
    end, {AccGuardedArray, -1}, lists:seq(0, M-1)),
    FinalGuardedArray.

pass_cols_bu(M, N, GridArray, AccGuardedArray) ->
    lists:foldl(fun(C, CurrentGuardedArray) ->
        pass_col_bu_single_col(C, M, GridArray, CurrentGuardedArray)
    end, AccGuardedArray, lists:seq(0, N-1)).

pass_col_bu_single_col(C, M, GridArray, AccGuardedArray) ->
    {FinalGuardedArray, _LastGuardRow} = lists:foldl(fun(R, {CurrentGuardedArray, LastGuardRow}) ->
        CellVal = get_cell(R, C, GridArray),
        if CellVal == 1 ->
            {CurrentGuardedArray, -1};
        CellVal == 2 ->
            {CurrentGuardedArray, R};
        true ->
            if LastGuardRow /= -1 ->
                NewGuardedArray = set_cell(R, C, 1, CurrentGuardedArray),
                {NewGuardedArray, LastGuardRow};
            true ->
                {CurrentGuardedArray, LastGuardRow}
            end
        end
    end, {AccGuardedArray, -1}, lists:seq(M-1, 0, -1)),
    FinalGuardedArray.

count_unguarded(M, N, GridArray, GuardedArray) ->
    lists:foldl(fun(R, Acc) ->
        lists:foldl(fun(C, InnerAcc) ->
            GridCellVal = get_cell(R, C, GridArray),
            GuardedCellVal = get_cell(R, C, GuardedArray),
            if GridCellVal == 0 and GuardedCellVal == 0 ->
                InnerAcc + 1;
            true ->
                InnerAcc
            end
        end, Acc, lists:seq(0, N-1))
    end, 0, lists:seq(0, M-1)).