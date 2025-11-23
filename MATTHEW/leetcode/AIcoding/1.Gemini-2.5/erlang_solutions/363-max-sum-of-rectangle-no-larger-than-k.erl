-module(solution).
-export([max_sum_submatrix/2]).

max_sum_submatrix(Matrix, K) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),

    {EffectiveRows, EffectiveCols, EffectiveMatrix} = 
        if Rows > Cols ->
            {Cols, Rows, transpose(Matrix)};
        true ->
            {Rows, Cols, Matrix}
        end,

    Matrix_arr = array:from_list(lists:map(fun array:from_list/1, EffectiveMatrix)),

    InitialMaxSum = -2000000000, 

    lists:foldl(fun(C1, AccMaxSum1) ->
        CurrentRowSums_arr = array:new([{size, EffectiveRows}, {default, 0}]),

        lists:foldl(fun(C2, AccMaxSum2) ->
            UpdatedRowSums_arr = update_row_sums_for_col_array(Matrix_arr, CurrentRowSums_arr, C2, EffectiveRows),
            UpdatedRowSums_list = array:to_list(UpdatedRowSums_arr),
            CurrentMaxSubarraySum = max_subarray_sum_no_larger_than_k(UpdatedRowSums_list, K),
            max(AccMaxSum2, CurrentMaxSubarraySum)
        end, AccMaxSum1, lists:seq(C1, EffectiveCols - 1))
    end, InitialMaxSum, lists:seq(0, EffectiveCols - 1)).

transpose(Matrix) ->
    case Matrix of
        [] -> [];
        [[]|_] -> [];
        _ ->
            [lists:map(fun hd/1, Matrix) | transpose(lists:map(fun tl/1, Matrix))]
    end.

update_row_sums_for_col_array(Matrix_arr, CurrentRowSums_arr, C2, EffectiveRows) ->
    lists:foldl(fun(R, AccArray) ->
        Row_arr = array:get(R, Matrix_arr), 
        Element = array:get(C2, Row_arr),   
        CurrentSum = array:get(R, AccArray), 
        array:set(R, CurrentSum + Element, AccArray) 
    end, CurrentRowSums_arr, lists:seq(0, EffectiveRows - 1)).

max_subarray_sum_no_larger_than_k(Nums, K) ->
    Tree = gb_trees:insert(0, 0, gb_trees:empty()),
    CurrentSum = 0,
    MaxSum = -2000000000, 

    {_FinalCurrentSum, FinalMaxSum, _FinalTree} = lists:foldl(
        fun(Num, {AccCurrentSum, AccMaxSum, AccTree}) ->
            NewCurrentSum = AccCurrentSum + Num,
            case gb_trees:lookup_ge(NewCurrentSum - K, AccTree) of
                {value, P_i, _} ->
                    NewMaxSum = max(AccMaxSum, NewCurrentSum - P_i);
                nomatch ->
                    NewMaxSum = AccMaxSum
            end,
            NewTree = gb_trees:insert(NewCurrentSum, NewCurrentSum, AccTree),
            {NewCurrentSum, NewMaxSum, NewTree}
        end,
        {CurrentSum, MaxSum, Tree},
        Nums
    ),
    FinalMaxSum.