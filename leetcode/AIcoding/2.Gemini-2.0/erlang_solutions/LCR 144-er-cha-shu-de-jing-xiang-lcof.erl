-module(invert_tree).
-export([invertTree/1]).

-type tree_node() :: {integer(), tree_node(), tree_node()} | nil.

invertTree(nil) ->
    nil;
invertTree({Val, Left, Right}) ->
    {Val, invertTree(Right), invertTree(Left)}.