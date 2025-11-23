-module(minimum_absolute_difference_in_bst).
-export([get_minimum_difference/1]).

get_minimum_difference(Node) ->
    {Min, _} = traverse(Node, []),
    Min.

traverse(nil, Acc) ->
    {infinity, Acc};
traverse({Val, Left, Right}, Acc) ->
    {LeftMin, LeftAcc} = traverse(Left, Acc),
    {RightMin, RightAcc} = traverse(Right, [Val | LeftAcc]),
    CurrentMin = min(abs(Val - lists:last(LeftAcc)), abs(Val - lists:hd(RightAcc))),
    Min = min(CurrentMin, min(LeftMin, RightMin)),
    {Min, [Val | RightAcc]}.