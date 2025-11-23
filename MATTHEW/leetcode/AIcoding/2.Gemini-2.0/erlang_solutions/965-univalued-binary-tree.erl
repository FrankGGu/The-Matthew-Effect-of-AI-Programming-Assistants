-module(univalued_binary_tree).
-export([isUnivalTree/1]).

-spec isUnivalTree(TreeNode :: treeNode()) -> boolean().

-type treeNode() :: {'TreeNode', integer(), treeNode(), treeNode()} | null.

isUnivalTree(Root) ->
    case Root of
        null ->
            true;
        {'TreeNode', Val, Left, Right} ->
            isUnivalTreeHelper(Root, Val)
    end.

isUnivalTreeHelper(null, _) ->
    true;
isUnivalTreeHelper({'TreeNode', Val, Left, Right}, RootVal) ->
    Val =:= RootVal andalso
    isUnivalTreeHelper(Left, RootVal) andalso
    isUnivalTreeHelper(Right, RootVal).