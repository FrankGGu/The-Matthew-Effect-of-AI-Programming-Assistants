-module(solution).
-export([min_diff_in_bst/1]).

min_diff_in_bst(Root) ->
    % Initial state: previous value is 'null' (no node visited yet), minimum difference is infinity.
    % The helper function returns {FinalPrevVal, FinalMinDiff}. We only need FinalMinDiff.
    {_FinalPrevVal, FinalMinDiff} = inorder_traverse(Root, {null, infinity}),
    FinalMinDiff.

inorder_traverse(null, State) ->
    State;
inorder_traverse({Val, Left, Right}, {PrevVal, MinDiff}) ->
    % 1. Recursively traverse the left subtree.
    % This will return the state after processing the left subtree,
    % including the last visited node's value (NewPrevValFromLeft) and the min diff found there.
    {NewPrevValFromLeft, MinDiffFromLeft} = inorder_traverse(Left, {PrevVal, MinDiff}),

    % 2. Process the current node.
    % Calculate the difference with the previously visited node (from the left subtree or initial state).
    CurrentMinDiff =
        case NewPrevValFromLeft of
            null ->
                % This is the very first node visited in the in-order traversal,
                % so there's no previous node to compare with.
                MinDiffFromLeft;
            _ ->
                % Calculate the difference between the current node's value and the previous node's value.
                % Since it's an in-order traversal of a BST, Val will always be greater than NewPrevValFromLeft.
                min(MinDiffFromLeft, Val - NewPrevValFromLeft)
        end,

    % 3. Recursively traverse the right subtree.
    % The current node's value (Val) becomes the 'PrevVal' for the right subtree traversal.
    inorder_traverse(Right, {Val, CurrentMinDiff}).