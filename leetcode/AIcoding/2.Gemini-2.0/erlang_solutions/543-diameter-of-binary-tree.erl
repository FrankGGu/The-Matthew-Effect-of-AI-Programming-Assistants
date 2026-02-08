-module(diameter_of_binary_tree).
-export([diameterOfBinaryTree/1]).

-record(tree_node, {val, left, right}).

diameterOfBinaryTree(Root) ->
    {_, Diameter} = diameterHelper(Root),
    Diameter.

diameterHelper(null) ->
    {0, 0};
diameterHelper(#tree_node{left = Left, right = Right}) ->
    {LeftHeight, LeftDiameter} = diameterHelper(Left),
    {RightHeight, RightDiameter} = diameterHelper(Right),
    Height = max(LeftHeight, RightHeight) + 1,
    Diameter = max([LeftDiameter, RightDiameter, LeftHeight + RightHeight]),
    {Height, Diameter}.