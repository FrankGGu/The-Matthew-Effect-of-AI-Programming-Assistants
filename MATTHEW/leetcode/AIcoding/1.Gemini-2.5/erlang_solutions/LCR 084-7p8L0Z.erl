-module(solution).
-export([permute_unique/1]).

permute_unique(Nums) ->
    SortedNums = lists:sort(Nums),
    Len = length(SortedNums),
    % Handle empty input list
    if Len == 0 ->
        [[]];
    true ->
        % Initialize a tuple to keep track of used elements by their original index.
        % Tuples are used for efficient element access and update.
        InitialUsedTuple = list_to_tuple(lists:duplicate(Len, false)),
        % Use a set to store unique permutations (as tuples) to automatically handle duplicates.
        % The 'dfs' function will return the final set.
        FinalSet = dfs(SortedNums, Len, [], InitialUsedTuple, sets:new()),
        % Convert the set of tuples back to a list of lists.
        lists:map(fun erlang:tuple_to_list/1, sets:to_list(FinalSet))
    end.

dfs(Nums, Len, CurrentPermutation, UsedTuple, AccSet) ->
    % Base case: If the current permutation has reached the desired length,
    % it's a complete permutation. Add it to the accumulator set.
    if length(CurrentPermutation) == Len ->
        sets:add_element(erlang:list_to_tuple(CurrentPermutation), AccSet);
    true ->
        % Recursive step: Iterate through all elements in the original (sorted) Nums list.
        % Idx is 0-indexed.
        lists:foldl(fun(Idx, CurrentAccSet) ->
            % Get the element at the current index (1-based for lists:nth).
            Element = lists:nth(Idx + 1, Nums),
            % Check if this element has already been used in the current permutation path.
            % (1-based for tuple element access).
            if element(Idx + 1, UsedTuple) == false ->
                % Duplicate handling logic:
                % If the current element is the same as the previous element in the sorted Nums list,
                % AND the previous element (at Idx-1) has NOT been used yet in the current path,
                % then skip the current element. This prevents generating identical permutations
                % when multiple identical numbers are available.
                % Example: For [1,1,2], if we pick Nums[0] (the first 1), then later when we
                % consider picking Nums[1] (the second 1), if Nums[0] was available but not picked,
                % we should skip Nums[1] to avoid generating permutations starting with the second 1
                % that would be identical to those starting with the first 1.
                if Idx > 0 and lists:nth(Idx, Nums) == Element and element(Idx, UsedTuple) == false ->
                    CurrentAccSet; % Skip this branch, return the accumulator set unchanged
                true ->
                    % Mark the current element as used in the UsedTuple.
                    NewUsedTuple = setelement(Idx + 1, UsedTuple, true),
                    % Recursively call dfs with the updated permutation and used elements.
                    dfs(Nums, Len, CurrentPermutation ++ [Element], NewUsedTuple, CurrentAccSet)
                end;
            true ->
                CurrentAccSet % Element at index Idx already used, skip this branch
            end
        end, AccSet, lists:seq(0, Len - 1)) % Iterate Idx from 0 to Len-1
    end.