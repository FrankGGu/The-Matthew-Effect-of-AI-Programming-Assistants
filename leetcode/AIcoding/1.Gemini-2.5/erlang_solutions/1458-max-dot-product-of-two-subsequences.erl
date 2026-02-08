-module(solution).
-export([maxDotProduct/2]).

max2(A, B) when A > B -> A;
max2(A, B) -> B.

max3(A, B, C) -> max2(A, max2(B, C)).

maxDotProduct(Nums1, Nums2) ->
    M = length(Nums1),
    N = length(Nums2),
    MinVal = -1000000000, % Sufficiently small value for "negative infinity"

    % Convert lists to arrays for O(1) access
    Nums1_arr = array:from_list(Nums1),
    Nums2_arr = array:from_list(Nums2),

    % PrevRow represents DP[i-1]
    % CurrRow represents DP[i]
    % Both are of size N, 0-indexed
    PrevRow = array:new([{size, N}, {fixed, true}, {default, MinVal}]),
    CurrRow = array:new([{size, N}, {fixed, true}, {default, MinVal}]),

    % Base case for DP[0][0]
    % Nums1_arr and Nums2_arr are 0-indexed.
    N1_0 = array:get(0, Nums1_arr),
    N2_0 = array:get(0, Nums2_arr),
    PrevRow_init = array:set(0, N1_0 * N2_0, PrevRow),

    % Fill the first row (DP[0][j] for j from 1 to N-1)
    PrevRow_filled = fill_first_row(1, N, Nums1_arr, Nums2_arr, PrevRow_init, MinVal),

    % Fill the rest of the DP table (i from 1 to M-1)
    FinalRow = fill_dp(1, M, N, Nums1_arr, Nums2_arr, PrevRow_filled, CurrRow, MinVal),

    array:get(N-1, FinalRow).

fill_first_row(J, N, Nums1_arr, Nums2_arr, PrevRowAcc, _MinVal) ->
    if J >= N ->
        PrevRowAcc;
    true ->
        N1_0 = array:get(0, Nums1_arr),
        N2_J = array:get(J, Nums2_arr),
        Product = N1_0 * N2_J,

        PrevVal_J_minus_1 = array:get(J-1, PrevRowAcc), % DP[0][J-1]
        CurrentVal = max2(PrevVal_J_minus_1, Product),

        NewPrevRowAcc = array:set(J, CurrentVal, PrevRowAcc),
        fill_first_row(J+1, N, Nums1_arr, Nums2_arr, NewPrevRowAcc, _MinVal)
    end.

fill_dp(I, M, N, Nums1_arr, Nums2_arr, PrevRow, CurrRowTemplate, MinVal) ->
    if I >= M ->
        PrevRow; % PrevRow now holds the result for DP[M-1]
    true ->
        N1_I = array:get(I, Nums1_arr), % Nums1[I]

        % Handle CurrRow[0] (DP[I][0])
        N2_0 = array:get(0, Nums2_arr),
        Product_I_0 = N1_I * N2_0,
        PrevVal_I_0 = array:get(0, PrevRow), % DP[I-1][0]

        DP_I_0 = max2(PrevVal_I_0, Product_I_0),
        NewCurrRow = array:set(0, DP_I_0, CurrRowTemplate),

        % Fill the rest of CurrRow (j from 1 to N-1)
        UpdatedCurrRow = fill_current_row(I, 1, N, Nums1_arr, Nums2_arr, PrevRow, NewCurrRow, N1_I, MinVal),

        fill_dp(I+1, M, N, Nums1_arr, Nums2_arr, UpdatedCurrRow, CurrRowTemplate, MinVal)
    end.

fill_current_row(_I, J, N, Nums1_arr, Nums2_arr, PrevRow, CurrRowAcc, N1_I, MinVal) ->
    if J >= N ->
        CurrRowAcc;
    true ->
        N2_J = array:get(J, Nums2_arr), % Nums2[J]
        CurrentProduct = N1_I * N2_J,

        Option1 = array:get(J-1, CurrRowAcc),      % DP[I][J-1]
        Option2 = array:get(J, PrevRow),           % DP[I-1][J]
        Option3_base = array:get(J-1, PrevRow),    % DP[I-1][J-1]

        Option3_extended = max2(CurrentProduct, Option3_base + CurrentProduct),
        DP_val = max3(Option1, Option2, Option3_extended),

        NewCurrRowAcc = array:set(J, DP_val, CurrRowAcc),
        fill_current_row(_I, J+1, N, Nums1_arr, Nums2_arr, PrevRow, NewCurrRowAcc, N1_I, MinVal)
    end.