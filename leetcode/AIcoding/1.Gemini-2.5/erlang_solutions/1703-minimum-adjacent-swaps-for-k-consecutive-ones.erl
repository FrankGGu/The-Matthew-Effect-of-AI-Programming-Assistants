-module(solution).
-export([min_swaps/2]).

min_swaps(Nums, K) ->
    OnesIndices = get_ones_indices(Nums),
    M = length(OnesIndices),

    if M < K -> 0; % Not enough ones to form a block of K
       K == 1 -> 0; % No swaps needed for 1 consecutive one
       true ->
           % Calculate QValues: q_i = original_index_of_one_i - i
           % where i is the 0-indexed position of the one in the OnesIndices list.
           QValues = lists:map(fun({Idx, Val}) -> Val - Idx end, lists:zip(lists:seq(0, M-1), OnesIndices)),
           solve_sliding_window(QValues, K)
    end.

get_ones_indices(Nums) ->
    get_ones_indices(Nums, 0, []).

get_ones_indices([], _Idx, Acc) ->
    lists:reverse(Acc);
get_ones_indices([1|T], Idx, Acc) ->
    get_ones_indices(T, Idx+1, [Idx|Acc]);
get_ones_indices([_H|T], Idx, Acc) ->
    get_ones_indices(T, Idx+1, Acc).

solve_sliding_window(QValues, K) ->
    % Initialize the first window
    InitialWindow = lists:sublist(QValues, K),
    {L_tree, R_tree, L_sum, R_sum, L_size, R_size} = init_heaps(InitialWindow),

    CurrentCost = calculate_cost(L_tree, L_sum, R_sum, L_size, R_size),
    MinCost = CurrentCost,

    % Slide the window through the rest of QValues
    slide_window(QValues, K, K, L_tree, R_tree, L_sum, R_sum, L_size, R_size, MinCost).

init_heaps(Window) ->
    lists:foldl(
        fun(Val, {L, R, LS, RS, LC, RC}) ->
            {L2, R2, LS2, RS2, LC2, RC2} = add_val(Val, L, R, LS, RS, LC, RC),
            rebalance(L2, R2, LS2, RS2, LC2, RC2)
        end,
        {gb_trees:new(), gb_trees:new(), 0, 0, 0, 0},
        Window
    ).

add_val(Val, L_tree, R_tree, L_sum, R_sum, L_size, R_size) ->
    case gb_trees:is_empty(L_tree) of
        true ->
            % L_tree is empty, add to L_tree (first element)
            {gb_trees:insert(Val, 1, L_tree), R_tree, L_sum + Val, R_sum, L_size + 1, R_size};
        false ->
            % Peek the median (largest in L_tree)
            {{Median, _}, _} = gb_trees:take_largest(L_tree),
            if Val =< Median ->
                {gb_trees:insert(Val, 1, L_tree), R_tree, L_sum + Val, R_sum, L_size + 1, R_size};
            true ->
                {L_tree, gb_trees:insert(Val, 1, R_tree), L_sum, R_sum + Val, L_size, R_size + 1}
            end
    end.

remove_val(Val, L_tree, R_tree, L_sum, R_sum, L_size, R_size) ->
    % Peek the median (largest in L_tree)
    {{Median, _}, _} = gb_trees:take_largest(L_tree),
    if Val =< Median ->
        {gb_trees:delete(Val, L_tree), R_tree, L_sum - Val, R_sum, L_size - 1, R_size};
    true ->
        {L_tree, gb_trees:delete(Val, R_tree), L_sum, R_sum - Val, L_size, R_size - 1}
    end.

rebalance(L_tree, R_tree, L_sum, R_sum, L_size, R_size) ->
    if L_size > R_size + 1 ->
        % L_tree is too large, move its largest element to R_tree
        {{Median, _}, L_tree_new} = gb_trees:take_largest(L_tree),
        rebalance(L_tree_new, gb_trees:insert(Median, 1, R_tree),
                  L_sum - Median, R_sum + Median, L_size - 1, R_size + 1);
    R_size > L_size ->
        % R_tree is too large, move its smallest element to L_tree
        {{Median, _}, R_tree_new} = gb_trees:take_smallest(R_tree),
        rebalance(gb_trees:insert(Median, 1, L_tree), R_tree_new,
                  L_sum + Median, R_sum - Median, L_size + 1, R_size - 1);
    true ->
        % Heaps are balanced
        {L_tree, R_tree, L_sum, R_sum, L_size, R_size}
    end.

calculate_cost(L_tree, L_sum, R_sum, L_size, R_size) ->
    % Median is the largest element in L_tree
    {{Median, _}, _} = gb_trees:take_largest(L_tree),
    (L_size * Median - L_sum) + (R_sum - R_size * Median).

slide_window(QValues, K, CurrentIdx, L_tree, R_tree, L_sum, R_sum, L_size, R_size, MinCost) ->
    if CurrentIdx >= length(QValues) ->
        MinCost;
    true ->
        % Elements are 1-indexed for lists:nth
        OldVal = lists:nth(CurrentIdx - K + 1, QValues),
        NewVal = lists:nth(CurrentIdx + 1, QValues),

        % Remove old_val
        {L_tree1, R_tree1, L_sum1, R_sum1, L_size1, R_size1} = 
            remove_val(OldVal, L_tree, R_tree, L_sum, R_sum, L_size, R_size),

        % Add new_val
        {L_tree2, R_tree2, L_sum2, R_sum2, L_size2, R_size2} = 
            add_val(NewVal, L_tree1, R_tree1, L_sum1, R_sum1, L_size1, R_size1),

        % Rebalance the heaps
        {L_tree_final, R_tree_final, L_sum_final, R_sum_final, L_size_final, R_size_final} = 
            rebalance(L_tree2, R_tree2, L_sum2, R_sum2, L_size2, R_size2),

        % Calculate cost for the new window and update min_cost
        NewCost = calculate_cost(L_tree_final, L_sum_final, R_sum_final, L_size_final, R_size_final),
        UpdatedMinCost = min(MinCost, NewCost),

        % Continue sliding
        slide_window(QValues, K, CurrentIdx + 1, L_tree_final, R_tree_final, L_sum_final, R_sum_final, L_size_final, R_size_final, UpdatedMinCost)
    end.