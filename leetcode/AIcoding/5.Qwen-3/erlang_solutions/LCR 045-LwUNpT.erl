-module(solution).
-export([find_bottom_left_value/1]).

find_bottom_left_value(Root) ->
    find_bottom_left_value(Root, 0, 0, 0).

find_bottom_left_value(null, _, _, Val) ->
    Val;
find_bottom_left_value({Val, Left, Right}, Depth, MaxDepth, _) ->
    case Depth of
        D when D > MaxDepth ->
            find_bottom_left_value(Left, Depth + 1, Depth, Val),
            find_bottom_left_value(Right, Depth + 1, Depth, Val);
        _ ->
            find_bottom_left_value(Left, Depth + 1, MaxDepth, Val),
            find_bottom_left_value(Right, Depth + 1, MaxDepth, Val)
    end.