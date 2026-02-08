-module(btree_preorder).
-export([preorder_traversal/1]).

preorder_traversal(nil) -> [];
preorder_traversal(#{} = Node) ->
    [Node#{}.val | 
     preorder_traversal(Node#{}.left) ++ 
     preorder_traversal(Node#{}.right)].