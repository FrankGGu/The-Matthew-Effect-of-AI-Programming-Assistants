-module(solution).
-export([invert_tree/1]).

invert_tree(nil) -> nil;
invert_tree({Val, Left, Right}) ->
    {Val, invert_tree(Right), invert_tree(Left)}.