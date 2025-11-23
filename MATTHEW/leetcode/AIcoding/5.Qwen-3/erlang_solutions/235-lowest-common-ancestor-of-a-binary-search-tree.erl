-module(solution).
-export([lowest_common_ancestor/2]).

-record(TreeNode, {val, left, right}).

lowest_common_ancestor(P, Q) ->
    lowest_common_ancestor(P, Q, P#TreeNode.val, Q#TreeNode.val).

lowest_common_ancestor(P, Q, PV, QV) ->
    case P#TreeNode.val of
        PV when PV < QV ->
            lowest_common_ancestor(P#TreeNode.right, Q, PV, QV);
        QV when QV < PV ->
            lowest_common_ancestor(P#TreeNode.left, Q, PV, QV);
        _ ->
            P
    end.