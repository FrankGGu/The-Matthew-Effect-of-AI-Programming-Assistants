-module(solution).
-export([maxSumOfThreeSubarrays/2]).

maxSumOfThreeSubarrays(Nums, K) ->
    N = length(Nums),

    % 1. Calculate prefix sums
    % P[i] = sum of Nums[0]...Nums[i-1]
    % P is 0-indexed for P[0] = 0, P[1] = Nums[0], etc.
    % So P has length N+1, with indices 0 to N.
    P = array_prefix_sums(Nums, N),

    % 2. Calculate W (sums of subarrays of length K)
    % W[i] = sum of Nums[i]...Nums[i+K-1] = P[i+K] - P[i]
    % W has length N - K + 1. Indices 0 to N-K.
    W_len = N - K + 1,
    W_array = array:new({0, W_len - 1}),
    W_array_filled = calculate_W(0, W_len - 1, K, P, W_array),

    % 3. Calculate left array
    % left[i] = index p such that W[p] is maximum for 0 <= p <= i.
    % If multiple such p, choose the smallest p.
    Left_array = array:new({0, W_len - 1}),
    Left_array_filled = calculate_left(0, W_len - 1, W_array_filled, Left_array),

    % 4. Calculate right array
    % right[i] = index p such that W[p] is maximum for i <= p <= W_len-1.
    % If multiple such p, choose the smallest p.
    Right_array = array:new({0, W_len - 1}),
    Right_array_filled = calculate_right(W_len - 1, W_len - 1, W_array_filled, Right_array),

    % 5. Iterate j for the middle subarray
    % j ranges from K to N - 2*K (inclusive)
    % The indices i, j, l are 0-indexed starting positions of the subarrays.
    % i <= j-K
    % l >= j+K
    Middle_start_idx = K,
    Middle_end_idx = N - 2*K,

    {_MaxSum, ResultIndices} = find_max_sum_and_indices(Middle_start_idx, Middle_end_idx, K, W_array_filled, Left_array_filled, Right_array_filled, -1, []),

    ResultIndices.

array_prefix_sums(Nums, N) ->
    P = array:new({0, N}),
    P_0 = array:set(0, 0, P),
    array_prefix_sums_rec(Nums, 1, P_0).

array_prefix_sums_rec([], _Idx, P_acc) ->
    P_acc;
array_prefix_sums_rec([H|T], Idx, P_acc) ->
    PrevSum = array:get(Idx - 1, P_acc),
    CurrentSum = PrevSum + H,
    Updated_P_acc = array:set(Idx, CurrentSum, P_acc),
    array_prefix_sums_rec(T, Idx + 1, Updated_P_acc).

calculate_W(Idx, MaxIdx, K, P, W_array) ->
    if Idx > MaxIdx ->
        W_array;
    true ->
        Sum = array:get(Idx + K, P) - array:get(Idx, P),
        Updated_W_array = array:set(Idx, Sum, W_array),
        calculate_W(Idx + 1, MaxIdx, K, P, Updated_W_array)
    end.

calculate_left(Idx, MaxIdx, W_array, Left_array) ->
    if Idx > MaxIdx ->
        Left_array;
    true ->
        New_Left_array =
            if Idx == 0 ->
                array:set(Idx, 0, Left_array);
            true ->
                Val_W_Idx = array:get(Idx, W_array),
                Prev_Left_Idx = array:get(Idx - 1, Left_array),
                Val_W_Prev_Left_Idx = array:get(Prev_Left_Idx, W_array),
                if Val_W_Idx > Val_W_Prev_Left_Idx ->
                    array:set(Idx, Idx, Left_array);
                true -> % If sums are equal or current is smaller, keep the previous (smaller) index
                    array:set(Idx, Prev_Left_Idx, Left_array)
                end
            end,
        calculate_left(Idx + 1, MaxIdx, W_array, New_Left_array)
    end.

calculate_right(Idx, MaxIdx, W_array, Right_array) ->
    if Idx < 0 ->
        Right_array;
    true ->
        New_Right_array =
            if Idx == MaxIdx ->
                array:set(Idx, MaxIdx, Right_array);
            true ->
                Val_W_Idx = array:get(Idx, W_array),
                Next_Right_Idx = array:get(Idx + 1, Right_array),
                Val_W_Next_Right_Idx = array:get(Next_Right_Idx, W_array),
                if Val_W_Idx >= Val_W_Next_Right_Idx -> % If current sum is greater or equal, pick current index (smaller index)
                    array:set(Idx, Idx, Right_array);
                true ->
                    array:set(Idx, Next_Right_Idx, Right_array)
                end
            end,
        calculate_right(Idx - 1, MaxIdx, W_array, New_Right_array)
    end.

find_max_sum_and_indices(J_Idx, J_MaxIdx, K, W_array, Left_array, Right_array, MaxSum, ResultIndices) ->
    if J_Idx > J_MaxIdx ->
        {MaxSum, ResultIndices};
    true ->
        I_candidate = array:get(J_Idx - K, Left_array),
        L_candidate = array:get(J_Idx + K, Right_array),

        CurrentSum = array:get(I_candidate, W_array) + array:get(J_Idx, W_array) + array:get(L_candidate, W_array),

        {NewMaxSum, NewResultIndices} =
            if CurrentSum > MaxSum ->
                {CurrentSum, [I_candidate, J_Idx, L_candidate]};
            true -> % If CurrentSum <= MaxSum, keep the existing result (ensures lexicographical smallest)
                {MaxSum, ResultIndices}
            end,
        find_max_sum_and_indices(J_Idx + 1, J_MaxIdx, K, W_array, Left_array, Right_array, NewMaxSum, NewResultIndices)
    end.