-module(btree_inorder).
-export([inorder_traversal/1]).

inorder_traversal(nil) -> [];
inorder_traversal({Val, Left, Right}) ->
    inorder_traversal(Left) ++ [Val] ++ inorder_traversal(Right).