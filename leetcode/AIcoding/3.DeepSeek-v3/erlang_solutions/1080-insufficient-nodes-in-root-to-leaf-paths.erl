-spec sufficient_subset(TreeNode :: #tree_node{} | null, Limit :: integer()) -> #tree_node{} | null.
sufficient_subset(Root, Limit) ->
    case has_sufficient_path(Root, 0, Limit) of
        true -> Root;
        false -> null
    end.

has_sufficient_path(null, _Sum, _Limit) -> false;
has_sufficient_path(#tree_node{val = Val, left = null, right = null}, Sum, Limit) ->
    Sum + Val >= Limit;
has_sufficient_path(Node, Sum, Limit) ->
    NewSum = Sum + Node#tree_node.val,
    LeftSufficient = has_sufficient_path(Node#tree_node.left, NewSum, Limit),
    RightSufficient = has_sufficient_path(Node#tree_node.right, NewSum, Limit),
    NewLeft = if
        not LeftSufficient -> null;
        true -> Node#tree_node.left
    end,
    NewRight = if
        not RightSufficient -> null;
        true -> Node#tree_node.right
    end,
    Node1 = Node#tree_node{left = NewLeft, right = NewRight},
    case LeftSufficient orelse RightSufficient of
        true -> true;
        false -> false
    end.