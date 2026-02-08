-module(solution).
-export([canDistribute/2]).

canDistribute(Counts, Quantity) ->
    % Sort quantity in descending order to prune the search space faster.
    % Larger requests are attempted first, leading to earlier failures or successes.
    SortedQuantity = lists:sort(fun(A, B) -> A >= B end, Quantity),

    % Use an ETS table for memoization to store results of previously computed states.
    % 'set' type ensures unique keys, 'public' for accessibility within the process.
    Memo = ets:new(memo_table, [set, public]),

    % Start the Depth-First Search (DFS) from the first customer (index 0).
    % Initial state: customer_idx = 0, current_counts = Counts.
    dfs(0, Counts, SortedQuantity, Memo).

dfs(CustomerIdx, CurrentCounts, SortedQuantity, Memo) ->
    % Create a unique key for the current state.
    % CurrentCounts is a list, convert to a tuple for a valid ETS key.
    StateKey = {CustomerIdx, list_to_tuple(CurrentCounts)},

    % Check if this state has been computed before.
    case ets:lookup(Memo, StateKey) of
        [{StateKey, Result}] ->
            Result; % If memoized, return the stored result directly.
        [] ->
            % If not memoized, compute the result using solve_dfs.
            Result = solve_dfs(CustomerIdx, CurrentCounts, SortedQuantity, Memo),
            % Store the computed result in the memoization table for future use.
            ets:insert(Memo, {StateKey, Result}),
            Result
    end.

solve_dfs(CustomerIdx, _CurrentCounts, SortedQuantity, _Memo) when CustomerIdx >= length(SortedQuantity) ->
    true; % Base case: All customers have been successfully satisfied.
solve_dfs(CustomerIdx, CurrentCounts, SortedQuantity, Memo) ->
    % Get the quantity required by the current customer.
    % lists:nth is 1-indexed, so we use CustomerIdx + 1.
    Required = lists:nth(CustomerIdx + 1, SortedQuantity),

    N = length(CurrentCounts), % Number of different item types.

    % Iterate through each item type to see if it can satisfy the current customer.
    % This helper function will short-circuit if a valid path is found.
    try_item_types(1, N, Required, CustomerIdx, CurrentCounts, SortedQuantity, Memo).

try_item_types(ItemTypeIdx, MaxItemTypeIdx, _Required, _CustomerIdx, _CurrentCounts, _SortedQuantity, _Memo) when ItemTypeIdx > MaxItemTypeIdx ->
    false; % No more item types to try; current customer cannot be satisfied.
try_item_types(ItemTypeIdx, MaxItemTypeIdx, Required, CustomerIdx, CurrentCounts, SortedQuantity, Memo) ->
    % Get the count of the current item type.
    ItemCount = lists:nth(ItemTypeIdx, CurrentCounts),

    if ItemCount >= Required ->
        % If this item type has enough items to satisfy the current customer:
        % 1. Create a new list of counts with the item type's count reduced.
        UpdatedCounts = lists:replace_nth(ItemTypeIdx, ItemCount - Required, CurrentCounts),

        % 2. Recursively call dfs for the next customer (CustomerIdx + 1).
        % If this path leads to a complete solution, return true immediately.
        if dfs(CustomerIdx + 1, UpdatedCounts, SortedQuantity, Memo) ->
            true;
        true ->
            % 3. If the recursive call did not lead to a solution, backtrack.
            % Try the next item type for the current customer.
            try_item_types(ItemTypeIdx + 1, MaxItemTypeIdx, Required, CustomerIdx, CurrentCounts, SortedQuantity, Memo)
        end;
    true ->
        % If this item type does not have enough items, try the next item type.
        try_item_types(ItemTypeIdx + 1, MaxItemTypeIdx, Required, CustomerIdx, CurrentCounts, SortedQuantity, Memo)
    end.