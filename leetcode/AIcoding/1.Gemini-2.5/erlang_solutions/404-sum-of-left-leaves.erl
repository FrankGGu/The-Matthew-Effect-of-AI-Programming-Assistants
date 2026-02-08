-record(tree_node, {val, left, right}).

sum_of_left_leaves(Root) ->
    sum_left_leaves_helper(Root, false).

sum_left_leaves_helper(nil, _IsLeft) ->
    0;
sum_left_leaves_helper(#'tree_node'{val = Val, left = nil, right = nil}, true) ->
    Val;
sum_left_leaves_helper(Node = #'tree_node'{val = _Val, left = _Left, right = _Right}, _IsLeft) ->
    sum_left_leaves_helper(Node#tree_node.left, true) +
    sum_left_leaves_helper(Node#tree_node.right, false).