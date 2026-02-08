-module(solution).
-export([is_unival_tree/1]).

-record(node, {val, left = null, right = null}).

is_unival_tree(Root) ->
    case Root of
        null -> true;
        _ -> is_unival_tree_helper(Root, Root#node.val)
    end.

is_unival_tree_helper(null, _) -> true;
is_unival_tree_helper(Node, Val) ->
    Node#node.val == Val andalso
    is_unival_tree_helper(Node#node.left, Val) andalso
    is_unival_tree_helper(Node#node.right, Val).