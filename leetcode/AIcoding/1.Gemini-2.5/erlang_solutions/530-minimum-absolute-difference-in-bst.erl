-record(tree_node, {val, left = null, right = null}).

-spec min_abs_diff_in_bst(Root :: tree_node() | null) -> integer().
min_abs_diff_in_bst(Root) ->
    {_PrevVal, MinDiff} = inorder(Root, {null, infinity}),
    MinDiff.

inorder(null, Acc) ->
    Acc;
inorder(Node, {PrevVal, MinDiff}) ->
    {NewPrevValFromLeft, NewMinDiffFromLeft} = inorder(Node#tree_node.left, {PrevVal, MinDiff}),

    CurrentPrevVal = NewPrevValFromLeft,
    CurrentMinDiff = NewMinDiffFromLeft,

    UpdatedMinDiff = case CurrentPrevVal of
                         null -> CurrentMinDiff;
                         _ -> min(CurrentMinDiff, abs(Node#tree_node.val - CurrentPrevVal))
                     end,

    inorder(Node#tree_node.right, {Node#tree_node.val, UpdatedMinDiff}).