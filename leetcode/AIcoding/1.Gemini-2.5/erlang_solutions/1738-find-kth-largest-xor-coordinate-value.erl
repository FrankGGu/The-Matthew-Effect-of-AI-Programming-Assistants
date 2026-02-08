-module(solution).
-export([kthLargestValue/2]).

kthLargestValue(Matrix, K) ->
    M = length(Matrix),
    N = length(hd(Matrix)),

    Matrix_array_of_arrays = array:from_list([array:from_list(Row) || Row <- Matrix]),

    PrevRowDP_array = array:new([{size, N}, {default, 0}]),

    {AllXorValues_reversed, _} = calculate_dp_rows(0, M, N, Matrix_array_of_arrays, PrevRowDP_array, []),

    AllXorValues = lists:reverse(AllXorValues_reversed),

    SortedXorValues = lists:sort(fun(A, B) -> A >= B end, AllXorValues),

    lists:nth(K, SortedXorValues).

calculate_dp_rows(I, M, N, Matrix_array_of_arrays, PrevRowDP_array, AccXorValues) when I < M ->
    CurrentMatrixRow_array = array:get(I, Matrix_array_of_arrays),

    {CurrentRowDP_array, NewAccXorValues} = 
        calculate_dp_cols(0, N, I, CurrentMatrixRow_array, PrevRowDP_array, 0, array:new([{size, N}, {default, 0}]), AccXorValues),

    calculate_dp_rows(I + 1, M, N, Matrix_array_of_arrays, CurrentRowDP_array, NewAccXorValues);
calculate_dp_rows(M, _, _, _, _, AccXorValues) ->
    {AccXorValues, []}.

calculate_dp_cols(J, N, I, CurrentMatrixRow_array, PrevRowDP_array, PrevColDP_val, AccCurrentRowDP_array, AccXorValues) when J < N ->
    Val_matrix_ij = array:get(J, CurrentMatrixRow_array),

    DP_val_i_minus_1_j = case I > 0 of true -> array:get(J, PrevRowDP_array); false -> 0 end,

    DP_val_i_minus_1_j_minus_1 = case {I > 0, J > 0} of {true, true} -> array:get(J - 1, PrevRowDP_array); _ -> 0 end,

    CurrentDP_val_final = Val_matrix_ij
                          XOR DP_val_i_minus_1_j
                          XOR PrevColDP_val
                          XOR DP_val_i_minus_1_j_minus_1,

    NewAccCurrentRowDP_array = array:set(J, CurrentDP_val_final, AccCurrentRowDP_array),

    calculate_dp_cols(J + 1, N, I, CurrentMatrixRow_array, PrevRowDP_array, CurrentDP_val_final, NewAccCurrentRowDP_array, [CurrentDP_val_final | AccXorValues]);
calculate_dp_cols(N, _, _, _, _, _, AccCurrentRowDP_array, AccXorValues) ->
    {AccCurrentRowDP_array, AccXorValues}.