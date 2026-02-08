-module(solution).
-export([invertTree/1]).

invertTree(nil) ->
    nil;
invertTree(#'TreeNode'{val = Val, left = Left, right = Right}) ->
    NewLeft = invertTree(Right),
    NewRight = invertTree(Left),
    #'TreeNode'{val = Val, left = NewLeft, right = NewRight}.