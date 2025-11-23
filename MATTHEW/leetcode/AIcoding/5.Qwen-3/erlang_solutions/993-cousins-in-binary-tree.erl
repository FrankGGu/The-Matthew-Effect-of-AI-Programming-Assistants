-module(solution).
-export([is_cousins/2]).

is_cousins(Root, X, Y) ->
    {XDepth, XParent} = find_node(Root, X, 0, nil),
    {YDepth, YParent} = find_node(Root, Y, 0, nil),
    XDepth == YDepth andalso XParent /= YParent.

find_node(nil, _, _, _) -> {0, nil};
find_node({Val, Left, Right}, Target, Depth, Parent) ->
    if
        Val == Target -> {Depth, Parent};
        true ->
            case find_node(Left, Target, Depth + 1, Val) of
                {D, P} when D > 0 -> {D, P};
                _ ->
                    find_node(Right, Target, Depth + 1, Val)
            end
    end.