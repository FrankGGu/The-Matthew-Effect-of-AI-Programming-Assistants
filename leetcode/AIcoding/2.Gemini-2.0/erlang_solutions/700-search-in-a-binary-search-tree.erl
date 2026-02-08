-module(search_bst).
-export([searchBST/2]).

-spec searchBST(TreeNode :: {integer(), TreeNode, TreeNode}, Val :: integer()) -> TreeNode.
searchBST({Val, Left, Right}, Val) -> {Val, Left, Right};
searchBST({RootVal, Left, Right}, Val) when Val < RootVal ->
  case Left of
    null -> null;
    _ -> searchBST(Left, Val)
  end;
searchBST({RootVal, Left, Right}, Val) when Val > RootVal ->
  case Right of
    null -> null;
    _ -> searchBST(Right, Val)
  end;
searchBST(null, _) -> null.