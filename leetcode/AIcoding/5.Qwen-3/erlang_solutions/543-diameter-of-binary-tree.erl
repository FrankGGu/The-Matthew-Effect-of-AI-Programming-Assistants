-module(diameter_of_binary_tree).
-export([diameter/1]).

diameter(nil) -> 0;
diameter(Node) ->
    {_, MaxDiameter} = dfs(Node),
    MaxDiameter.

dfs(nil) -> {0, 0};
dfs(Node) ->
    {LeftHeight, LeftDiameter} = dfs(Node#tree.left),
    {RightHeight, RightDiameter} = dfs(Node#tree.right),
    CurrentDiameter = LeftHeight + RightHeight,
    MaxDiameter = max(CurrentDiameter, max(LeftDiameter, RightDiameter)),
    {max(LeftHeight, RightHeight) + 1, MaxDiameter}.

-record(tree, {val, left, right}).