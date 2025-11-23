-module(balanced_bst).
-export([balanceBST/1]).

-record(node, {val, left, right}).

balanceBST(undefined) -> undefined;
balanceBST(Node) ->
    List = inorder_traversal(Node),
    build_balanced_tree(List, 0, length(List) - 1).

inorder_traversal(undefined) -> [];
inorder_traversal(#node{val=Val, left=Left, right=Right}) ->
    LeftList = inorder_traversal(Left),
    RightList = inorder_traversal(Right),
    LeftList ++ [Val] ++ RightList.

build_balanced_tree(_, L, R) when L > R -> undefined;
build_balanced_tree(List, L, R) ->
    Mid = (L + R) div 2,
    Val = lists:nth(Mid + 1, List),
    Left = build_balanced_tree(List, L, Mid - 1),
    Right = build_balanced_tree(List, Mid + 1, R),
    #node{val=Val, left=Left, right=Right}.