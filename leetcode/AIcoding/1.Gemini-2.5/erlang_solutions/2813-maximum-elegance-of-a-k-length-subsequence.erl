-module(solution).
-export([maximum_elegance/2]).

maximum_elegance(Items, K) ->
    % Convert items from [[Profit, Category]] to [{Profit, Category}] tuples
    % and sort by Profit in descending order.
    TuplesItems = lists:map(fun([P, C]) -> {P, C} end, Items),
    SortedItems = lists:sort(fun({P1, _}, {P2, _}) -> P1 >= P2 end, TuplesItems),

    % Phase 1: Build the initial K-length subsequence using the K highest profit items.
    % State: {CurrentProfit, CurrentCategories, DuplicateProfitsHeap, IdCounter}
    % CurrentProfit: Sum of profits of items in the current K-subsequence.
    % CurrentCategories: A sets:set() of categories present in the current K-subsequence.
    % DuplicateProfitsHeap: A gb_trees used as a min-heap to store profits of items
    %                       that are part of the current K-subsequence AND whose categories
    %                       are already present (duplicates). Keys are {Profit, IdCounter}
    %                       to ensure uniqueness for gb_trees, values are Profit.
    % IdCounter: A monotonically increasing counter to generate unique keys for gb_trees.
    {InitialProfit, InitialCategories, InitialDuplicateProfitsHeap, InitialIdCounter} =
        lists:foldl(
            fun({P, C}, {AccProfit, AccCategories, AccHeap, IdCounter}) ->
                NewAccProfit = AccProfit + P,
                NewAccCategories = sets:add_element(C, AccCategories),
                NewAccHeap =
                    case sets:is_element(C, AccCategories) of
                        true -> gb_trees:insert({P, IdCounter}, P, AccHeap); % Add to heap if category is a duplicate
                        false -> AccHeap
                    end,
                {NewAccProfit, NewAccCategories, NewAccHeap, IdCounter + 1}
            end,
            {0, sets:new(), gb_trees:empty(), 0},
            lists:sublist(SortedItems, 1, K) % Take the first K items
        ),

    % Calculate the initial elegance.
    MaxElegance = InitialProfit + (sets:size(InitialCategories) * sets:size(InitialCategories)),

    % Phase 2: Iterate through the remaining items (from index K to N-1).
    % For each remaining item, try to swap it in if it introduces a new category
    % and we can remove a duplicate-category item from our current K-subsequence.
    % State: {AccMaxElegance, AccProfit, AccCategories, AccHeap, IdCounter}
    % IdCounter is passed along but not incremented here, as we are not adding new items to the heap.
    {FinalMaxElegance, _, _, _, _} =
        lists:foldl(
            fun({P, C}, {AccMaxElegance, AccProfit, AccCategories, AccHeap, IdCounter}) ->
                % Check if the current item's category is new AND if we have a duplicate to remove.
                case {sets:is_element(C, AccCategories), gb_trees:is_empty(AccHeap)} of
                    {false, false} -> % Category C is new, and there are duplicates to remove
                        % Extract the smallest profit item from the duplicates heap.
                        {{_SmallestDuplicateProfitKey, SmallestDuplicateProfitValue}, HeapWithoutMin} = gb_trees:smallest(AccHeap),

                        % Update total profit: remove the smallest duplicate profit, add current item's profit.
                        UpdatedProfit = AccProfit - SmallestDuplicateProfitValue + P,
                        % Add the new category to the set of categories.
                        UpdatedCategories = sets:add_element(C, AccCategories),

                        % Calculate the elegance for this new configuration.
                        CurrentElegance = UpdatedProfit + (sets:size(UpdatedCategories) * sets:size(UpdatedCategories)),

                        % Update the maximum elegance found so far.
                        {max(AccMaxElegance, CurrentElegance), UpdatedProfit, UpdatedCategories, HeapWithoutMin, IdCounter};
                    _ -> % Category C is not new, or no duplicates to remove. No swap is performed.
                        {AccMaxElegance, AccProfit, AccCategories, AccHeap, IdCounter}
                end
            end,
            {MaxElegance, InitialProfit, InitialCategories, InitialDuplicateProfitsHeap, InitialIdCounter},
            lists:nthtail(K, SortedItems) % Remaining items
        ),
    FinalMaxElegance.