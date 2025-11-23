-module(delete_leaves_with_given_value).
-export([remove_leaves/2]).

-record(TreeNode, {val, left, right}).

remove_leaves(undefined, _) ->
    undefined;
remove_leaves(Node, Target) ->
    Left = remove_leaves(Node#TreeNode.left, Target),
    Right = remove_leaves(Node#TreeNode.right, Target),
    case (Left == undefined) and (Right == undefined) of
        true ->
            if Node#TreeNode.val == Target -> undefined;
               true -> Node#TreeNode{left=Left, right=Right}
            end;
        false ->
            Node#TreeNode{left=Left, right=Right}
    end.