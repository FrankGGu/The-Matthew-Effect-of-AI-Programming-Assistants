-module(solution).

-export([find_subtree_sizes/2]).

-record(tree_node, {val, left = undefined, right = undefined}).

find_subtree_sizes(Tree, Queries) ->
    Sizes = map(fun(Query) -> subtree_size(Tree, Query) end, Queries),
    Sizes.

subtree_size(undefined, _) -> 0;
subtree_size(Node, Val) ->
    case Node#tree_node.val of
        Val -> 1 + subtree_size(Node#tree_node.left, Val) + subtree_size(Node#tree_node.right, Val);
        _ -> subtree_size(Node#tree_node.left, Val) + subtree_size(Node#tree_node.right, Val)
    end.