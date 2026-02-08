-module(solution).
-export([inorder_traversal/1]).

inorder_traversal(nil) ->
    [];
inorder_traversal({Value, Left, Right}) ->
    LeftResult = inorder_traversal(Left),
    RightResult = inorder_traversal(Right),
    LeftResult ++ [Value] ++ RightResult.