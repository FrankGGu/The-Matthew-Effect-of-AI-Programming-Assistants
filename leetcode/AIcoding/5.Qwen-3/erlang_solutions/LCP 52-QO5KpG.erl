-module(solution).
-export([paint_tree/1]).

paint_tree(BST) ->
    paint_tree(BST, 0).

paint_tree(nil, _) ->
    nil;
paint_tree({Value, Left, Right}, Depth) ->
    NewValue = Value + Depth,
    {NewValue, paint_tree(Left, Depth + 1), paint_tree(Right, Depth + 1)}.