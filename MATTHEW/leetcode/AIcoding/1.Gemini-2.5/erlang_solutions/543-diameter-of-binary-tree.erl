-module(leetcode).
-export([diameter_of_binary_tree/1]).

-record(tree_node, {val, left = nil, right = nil}).

diameter_of_binary_tree(Root) ->
    {_Height, Diameter} = dfs(Root),
    Diameter.

dfs(nil) ->
    {-1, 0};
dfs(#tree_node{left = Left, right = Right}) ->
    {LeftHeight, LeftDiameter} = dfs(Left),
    {RightHeight, RightDiameter} = dfs(Right),

    CurrentHeight = 1 + max(LeftHeight, RightHeight),
    DiameterThroughCurrent = (LeftHeight + 1) + (RightHeight + 1),

    CurrentDiameter = max(LeftDiameter, max(RightDiameter, DiameterThroughCurrent)),
    {CurrentHeight, CurrentDiameter}.