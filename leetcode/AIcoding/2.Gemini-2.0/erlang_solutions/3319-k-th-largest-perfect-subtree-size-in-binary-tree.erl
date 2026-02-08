-module(kth_largest_perfect_subtree).
-export([kth_largest_perfect_subtree/2]).

-spec kth_largest_perfect_subtree(Root :: tree(), K :: integer()) -> integer().
kth_largest_perfect_subtree(Root, K) ->
    Sizes = subtree_sizes(Root),
    SortedSizes = lists:sort(descending, Sizes),
    case lists:nth(K, SortedSizes) of
        N when is_integer(N) -> N;
        _ -> -1
    end.

subtree_sizes(null) ->
    [].

subtree_sizes(TreeNode) ->
    {Val, Left, Right} = TreeNode,
    LeftSizes = subtree_sizes(Left),
    RightSizes = subtree_sizes(Right),
    Size = subtree_size(TreeNode),
    [Size | LeftSizes ++ RightSizes].

subtree_size(null) ->
    0.

subtree_size(TreeNode) ->
    {Val, Left, Right} = TreeNode,
    if is_perfect(TreeNode) then
        tree_size(TreeNode)
    else
        0
    end.

is_perfect(null) ->
    true;
is_perfect({_, null, null}) ->
    true;
is_perfect({_, Left, Right}) ->
    TreeHeight = tree_height(Left),
    TreeHeight == tree_height(Right) andalso is_perfect(Left) andalso is_perfect(Right).

tree_size(null) ->
    0;
tree_size({_, Left, Right}) ->
    1 + tree_size(Left) + tree_size(Right).

tree_height(null) ->
    0;
tree_height({_, Left, Right}) ->
    1 + max(tree_height(Left), tree_height(Right)).

descending(A, B) ->
    A > B.

-type tree() :: {integer(), tree(), tree()} | null.