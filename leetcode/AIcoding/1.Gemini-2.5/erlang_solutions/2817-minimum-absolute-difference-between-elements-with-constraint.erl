-module(solution).
-export([min_absolute_difference/2]).

min_absolute_difference(Nums, X) ->
    Len = length(Nums),
    % Convert the input list to an array for O(1) element access
    NumsArray = array:from_list(Nums),

    % Initialize MinDiff to a value larger than any possible difference (max 10^9 - 1)
    InitialMinDiff = 2000000000, % A sufficiently large number

    % Initialize an empty gb_tree to store numbers.
    % gb_tree acts as a sorted set, allowing efficient lookup of closest elements.
    Tree = gb_trees:empty(),

    % Start the recursive loop
    min_absolute_difference_loop(0, NumsArray, X, Len, Tree, InitialMinDiff).

min_absolute_difference_loop(J, NumsArray, X, Len, Tree, CurrentMinDiff) when J < Len ->
    % Get the current number nums[J]
    NumJ = array:get(J, NumsArray),

    % Add nums[J - X] to the tree if the index J - X is valid.
    % This ensures that any element in the tree is at least X indices away from NumJ.
    NewTree =
        if
            J - X >= 0 ->
                NumToAdd = array:get(J - X, NumsArray),
                gb_trees:insert(NumToAdd, undefined, Tree); % Value can be 'undefined' as we only care about keys
            true ->
                Tree
        end,

    % Find the minimum absolute difference
    NextMinDiff =
        if
            % If the tree is empty, no comparison can be made yet.
            % This happens for the first X+1 iterations.
            gb_trees:is_empty(NewTree) ->
                CurrentMinDiff;
            true ->
                % Find the largest element in the tree less than or equal to NumJ
                DiffLe =
                    case gb_trees:lookup_le(NumJ, NewTree) of
                        {KeyLe, _} ->
                            abs(NumJ - KeyLe);
                        none ->
                            CurrentMinDiff % No such element, so this path doesn't improve diff
                    end,

                % Find the smallest element in the tree greater than or equal to NumJ
                DiffGe =
                    case gb_trees:lookup_ge(NumJ, NewTree) of
                        {KeyGe, _} ->
                            abs(NumJ - KeyGe);
                        none ->
                            CurrentMinDiff % No such element, so this path doesn't improve diff
                    end,

                % Update the overall minimum difference
                min(CurrentMinDiff, min(DiffLe, DiffGe))
        end,

    % Recurse for the next index J
    min_absolute_difference_loop(J + 1, NumsArray, X, Len, NewTree, NextMinDiff);

min_absolute_difference_loop(_J, _NumsArray, _X, _Len, _Tree, CurrentMinDiff) ->
    CurrentMinDiff.