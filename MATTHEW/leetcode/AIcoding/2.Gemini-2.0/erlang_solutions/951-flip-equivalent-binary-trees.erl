-module(flip_equivalent_binary_trees).
-export([flipEquiv/2]).

-spec flipEquiv(TreeNode :: treeNode(), TreeNode :: treeNode()) -> boolean().
flipEquiv(null, null) -> true;
flipEquiv(null, _) -> false;
flipEquiv(_, null) -> false;
flipEquiv(TreeNode{val = V1, left = L1, right = R1}, TreeNode{val = V2, left = L2, right = R2}) ->
    V1 =:= V2 andalso
    (flipEquiv(L1, L2) andalso flipEquiv(R1, R2)) orelse
    (flipEquiv(L1, R2) andalso flipEquiv(R1, L2)).

-type treeNode() :: null | TreeNode.
-record(TreeNode, {val :: integer(), left :: treeNode(), right :: treeNode()}).