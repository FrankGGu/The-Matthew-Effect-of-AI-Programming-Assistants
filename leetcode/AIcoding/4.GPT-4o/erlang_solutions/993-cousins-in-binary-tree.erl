-module(solution).
-export([isCousins/3]).

-record(node, {val, left = null, right = null}).

isCousins(Root, X, Y) ->
    case find_depth(Root, X, 0, 0) of
        {DepthX, ParentX} ->
            case find_depth(Root, Y, 0, 0) of
                {DepthY, ParentY} ->
                    DepthX == DepthY andalso ParentX =/= ParentY;
                _ -> false
            end;
        _ -> false
    end.

find_depth(null, _, _, _) -> 
    {0, null};
find_depth(#node{val=Value, left=Left, right=Right}, Target, Depth, Parent) when Value =:= Target ->
    {Depth, Parent};
find_depth(#node{left=Left} = Node, Target, Depth, Parent) ->
    find_depth(Left, Target, Depth + 1, Node);
find_depth(#node{right=Right} = Node, Target, Depth, Parent) ->
    find_depth(Right, Target, Depth + 1, Node).