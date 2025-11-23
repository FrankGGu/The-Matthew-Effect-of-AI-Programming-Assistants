-module(solution).
-export([lowest_common_ancestor/2]).

-record(TreeNode, {val, left, right}).

lowest_common_ancestor(_Root, _P, _Q) ->
    lowest_common_ancestor_helper(_Root, _P, _Q).

lowest_common_ancestor_helper(nil, _P, _Q) ->
    nil;
lowest_common_ancestor_helper(Node, P, Q) ->
    case compare_val(Node, P) of
        less ->
            lowest_common_ancestor_helper(Node#TreeNode.right, P, Q);
        greater ->
            lowest_common_ancestor_helper(Node#TreeNode.left, P, Q);
        equal ->
            case compare_val(Node, Q) of
                equal ->
                    Node;
                _ ->
                    case compare_val(Node#TreeNode.left, P) of
                        equal ->
                            case compare_val(Node#TreeNode.left, Q) of
                                equal ->
                                    Node;
                                _ ->
                                    Node
                            end;
                        _ ->
                            case compare_val(Node#TreeNode.right, Q) of
                                equal ->
                                    Node;
                                _ ->
                                    Node
                            end
                    end
            end
    end.

compare_val(Node, Target) ->
    if
        Node#TreeNode.val < Target#TreeNode.val -> less;
        Node#TreeNode.val > Target#TreeNode.val -> greater;
        true -> equal
    end.