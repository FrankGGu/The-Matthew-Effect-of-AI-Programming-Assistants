-module(solution).
-export([trimBST/3]).

trimBST(nil, _Low, _High) ->
    nil;
trimBST({node, Val, Left, Right}, Low, High) when Val > High ->
    trimBST(Left, Low, High);
trimBST({node, Val, Left, Right}, Low, High) when Val < Low ->
    trimBST(Right, Low, High);
trimBST({node, Val, Left, Right}, Low, High) ->
    NewLeft = trimBST(Left, Low, High),
    NewRight = trimBST(Right, Low, High),
    {node, Val, NewLeft, NewRight}.