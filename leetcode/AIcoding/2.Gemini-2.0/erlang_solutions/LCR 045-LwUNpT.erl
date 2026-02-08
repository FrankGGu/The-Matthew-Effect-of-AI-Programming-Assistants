-module(find_bottom_left_tree_value).
-export([find_bottom_left_value/1]).

find_bottom_left_value(Root) ->
    find_bottom_left_value(Root, 0, 0, -1).

find_bottom_left_value(null, _, Value, Depth) ->
    {Value, Depth};
find_bottom_left_value({Val, Left, Right}, CurrentDepth, _, Depth) when CurrentDepth > Depth ->
    {Val, CurrentDepth};
find_bottom_left_value({_Val, Left, Right}, CurrentDepth, Value, Depth) ->
    {LeftValue, LeftDepth} = find_bottom_left_value(Left, CurrentDepth + 1, Value, Depth),
    {RightValue, RightDepth} = find_bottom_left_value(Right, CurrentDepth + 1, LeftValue, LeftDepth),
    {RightValue, RightDepth}.