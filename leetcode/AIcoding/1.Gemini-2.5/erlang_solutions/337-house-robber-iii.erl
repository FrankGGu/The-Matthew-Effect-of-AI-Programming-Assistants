-module(solution).
-export([rob/1]).

-record(tree_node, {val, left = nil, right = nil}).

rob(Root) ->
    {Robbed, NotRobbed} = rob_node(Root),
    max(Robbed, NotRobbed).

rob_node(nil) ->
    {0, 0};
rob_node(#tree_node{val = Val, left = Left, right = Right}) ->
    {LeftRobbed, LeftNotRobbed} = rob_node(Left),
    {RightRobbed, RightNotRobbed} = rob_node(Right),

    % If we rob the current node, we cannot rob its children.
    CurrentRobbed = Val + LeftNotRobbed + RightNotRobbed,

    % If we don't rob the current node, we can choose to rob or not rob its children
    % to maximize the sum.
    CurrentNotRobbed = max(LeftRobbed, LeftNotRobbed) + max(RightRobbed, RightNotRobbed),

    {CurrentRobbed, CurrentNotRobbed}.