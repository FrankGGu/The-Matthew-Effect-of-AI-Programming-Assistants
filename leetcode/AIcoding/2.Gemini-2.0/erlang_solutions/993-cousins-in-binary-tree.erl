-module(cousins_in_binary_tree).
-export([is_cousins/2]).

is_cousins(Root, X, Y) ->
    {XParent, XDepth} = find_node(Root, X, 0, null),
    {YParent, YDepth} = find_node(Root, Y, 0, null),
    XDepth == YDepth andalso XParent /= YParent.

find_node(null, _, _, _) ->
    {null, -1};
find_node({Val, Left, Right}, Target, Depth, Parent) when Val == Target ->
    {Parent, Depth};
find_node({Val, Left, Right}, Target, Depth, Parent) ->
    ResultLeft = find_node(Left, Target, Depth + 1, Val),
    ResultRight = find_node(Right, Target, Depth + 1, Val),
    case ResultLeft of
        {_, D} when D >= 0 ->
            ResultLeft;
        _ ->
            ResultRight
    end.