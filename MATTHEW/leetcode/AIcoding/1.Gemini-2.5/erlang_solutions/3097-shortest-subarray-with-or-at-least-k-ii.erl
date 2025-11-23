-module(solution).
-export([shortest_subarray_or_at_least_k/2]).

init_bit_counts() ->
    list_to_tuple(lists:duplicate(32, 0)).

update_bit_counts_add(Num, BitCounts) ->
    update_bit_counts_add_recursive(Num, 0, BitCounts).

update_bit_counts_add_recursive(_Num, 32, BitCounts) ->
    BitCounts;
update_bit_counts_add_recursive(Num, Bit, BitCounts) ->
    IfBitSet = (Num band (1 bsl Bit)) /= 0,
    NewBitCounts =
        if IfBitSet ->
            Count = element(Bit + 1, BitCounts),
            setelement(Bit + 1, BitCounts, Count + 1);
        true ->
            BitCounts
        end,
    update_bit_counts_add_recursive(Num, Bit + 1, NewBitCounts).

update_bit_counts_remove(Num, BitCounts) ->
    update_bit_counts_remove_recursive(Num, 0, BitCounts).

update_bit_counts_remove_recursive(_Num, 32, BitCounts) ->
    BitCounts;
update_bit_counts_remove_recursive(Num, Bit, BitCounts) ->
    IfBitSet = (Num band (1 bsl Bit)) /= 0,
    NewBitCounts =
        if IfBitSet ->
            Count = element(Bit + 1, BitCounts),
            setelement(Bit + 1, BitCounts, Count - 1);
        true ->
            BitCounts
        end,
    update_bit_counts_remove_recursive(Num, Bit + 1, NewBitCounts).

calculate_or_sum(BitCounts) ->
    calculate_or_sum_recursive(0, 0, BitCounts).

calculate_or_sum_recursive(32, CurrentOR, _BitCounts) ->
    CurrentOR;
calculate_or_sum_recursive(Bit, CurrentOR, BitCounts) ->
    Count = element(Bit + 1, BitCounts),
    NewOR =
        if Count > 0 ->
            CurrentOR bor (1 bsl Bit);
        true ->
            CurrentOR
        end,
    calculate_or_sum_recursive(Bit + 1, NewOR, BitCounts).

shortest_subarray_or_at_least_k(Nums, K) ->
    N = length(Nums),
    NumsArray = gb_array:from_list(Nums),

    Left = 0, % 0-indexed
    BitCounts = init_bit_counts(),
    MinLen = infinity,

    shortest_subarray_or_at_least_k_recursive(Left, 0, N, NumsArray, K, BitCounts, MinLen).

shortest_subarray_or_at_least_k_recursive(Left, Right, N, NumsArray, K, BitCounts, MinLen) when Right < N ->
    % Expand window to the right
    NumRight = gb_array:get(Right, NumsArray),
    NewBitCountsAdd = update_bit_counts_add(NumRight, BitCounts),
    CurrentOR = calculate_or_sum(NewBitCountsAdd),

    % Shrink window from the left if current OR sum is >= K
    % This inner loop tries to find the shortest valid subarray ending at 'Right'
    {FinalLeft, FinalMinLen, FinalBitCounts} = 
        shrink_window(Left, Right, NumsArray, K, NewBitCountsAdd, CurrentOR, MinLen),

    % Move to the next right element
    shortest_subarray_or_at_least_k_recursive(FinalLeft, Right + 1, N, NumsArray, K, FinalBitCounts, FinalMinLen);

shortest_subarray_or_at_least_k_recursive(_Left, _Right, _N, _NumsArray, _K, _BitCounts, MinLen) ->
    % All elements processed
    case MinLen of
        infinity -> -1;
        _ -> MinLen
    end.

shrink_window(Left, Right, NumsArray, K, BitCounts, CurrentOR, MinLen) ->
    if CurrentOR >= K ->
        % Update min length
        NewMinLen = min(MinLen, Right - Left + 1),

        % Try to shrink from left
        NumLeft = gb_array:get(Left, NumsArray),
        NewBitCountsRemove = update_bit_counts_remove(NumLeft, BitCounts),
        NewCurrentORRemove = calculate_or_sum(NewBitCountsRemove),

        % Recurse with shrunk window
        shrink_window(Left + 1, Right, NumsArray, K, NewBitCountsRemove, NewCurrentORRemove, NewMinLen);
    true ->
        % Current OR sum is less than K, or Left has caught up with Right, stop shrinking
        % We return the state before the last unsuccessful shrink attempt
        {Left, MinLen, BitCounts}
    end.