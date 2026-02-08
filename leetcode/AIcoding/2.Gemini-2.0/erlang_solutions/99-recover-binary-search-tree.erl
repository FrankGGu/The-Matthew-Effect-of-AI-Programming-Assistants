-module(recover_bst).
-export([recoverTree/1]).

-spec recoverTree(TreeNode()) -> TreeNode().
recoverTree(Root) ->
    {Nodes, First, Second, Prev} = inOrder(Root, [], undefined, undefined, undefined),
    case {First, Second} of
        {undefined, undefined} -> Root;
        {undefined, S} ->
            S#tree_node.val = Root#tree_node.val,
            Root#tree_node.val = S#tree_node.val;
        {F, undefined} ->
            F#tree_node.val = Root#tree_node.val,
            Root#tree_node.val = F#tree_node.val;
        {F, S} ->
            Temp = F#tree_node.val,
            F#tree_node.val = S#tree_node.val,
            S#tree_node.val = Temp
    end,
    Root.

inOrder(Node, Acc, First, Second, Prev) when Node == undefined ->
    {lists:reverse(Acc), First, Second, Prev};
inOrder(Node, Acc, First, Second, Prev) ->
    {LeftNodes, F1, S1, P1} = inOrder(Node#tree_node.left, Acc, First, Second, Prev),
    {F2, S2, P2} =
        case Prev of
            undefined -> {F1, S1, Node};
            P ->
                if Node#tree_node.val < P#tree_node.val then
                    case F1 of
                        undefined -> {Node, S1, Node};
                        _ -> {F1, Node, Node}
                    end
                else
                    {F1, S1, Node}
                end
        end,
    {RightNodes, F3, S3, P3} = inOrder(Node#tree_node.right, LeftNodes ++ [Node], F2, S2, P2),
    {RightNodes, F3, S3, P3}.

-type TreeNode() :: #tree_node{}.
-record(tree_node, {val, left, right}).