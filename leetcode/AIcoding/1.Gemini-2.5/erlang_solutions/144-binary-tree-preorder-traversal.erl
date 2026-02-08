-module(solution).
-export([preorder_traversal/1]).

preorder_traversal(nil) ->
    [];
preorder_traversal({Val, Left, Right}) ->
    [Val | preorder_traversal(Left) ++ preorder_traversal(Right)].