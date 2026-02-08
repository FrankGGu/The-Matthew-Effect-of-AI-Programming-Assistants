-module(solution).
-export([decorate_tree/1]).

decorate_tree(Tree) ->
    decorate_tree_helper(Tree, 0).

decorate_tree_helper(nil, _) ->
    nil;
decorate_tree_helper({Value, Left, Right}, Depth) ->
    NewLeft = decorate_tree_helper(Left, Depth + 1),
    NewRight = decorate_tree_helper(Right, Depth + 1),
    {Value, Depth, NewLeft, NewRight}.