-module(solution).
-export([invert_tree/1]).

invert_tree(nil) ->
    nil;
invert_tree({Val, Left, Right}) ->
    InvertedLeft = invert_tree(Left),
    InvertedRight = invert_tree(Right),
    {Val, InvertedRight, InvertedLeft}.