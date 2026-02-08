-module(prune_tree).
-export([pruneTree/1]).

-spec pruneTree(TreeNode()) -> TreeNode().
pruneTree(null) ->
    null;
pruneTree(TreeNode) ->
    pruneTreeHelper(TreeNode).

pruneTreeHelper(null) ->
    null;
pruneTreeHelper({Val, Left, Right}) ->
    LeftPruned = pruneTreeHelper(Left),
    RightPruned = pruneTreeHelper(Right),
    case {Val, LeftPruned, RightPruned} of
        {0, null, null} ->
            null;
        {1, null, null} ->
            {1, null, null};
        {_, _, _} ->
            {Val, LeftPruned, RightPruned}
    end.

-type TreeNode() :: {integer(), TreeNode(), TreeNode()} | null.