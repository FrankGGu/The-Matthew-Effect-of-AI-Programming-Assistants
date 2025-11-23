-module(solution).
-export([isCousins/3]).

isCousins(Root, X, Y) ->
    {DepthX, ParentX} = find_info(Root, X, 0, -1), % -1 represents a non-existent parent for the root
    {DepthY, ParentY} = find_info(Root, Y, 0, -1),
    DepthX == DepthY andalso ParentX =/= ParentY.

find_info(nil, _, _, _) ->
    nil;
find_info({Val, Left, Right}, TargetVal, CurrentDepth, ParentVal) ->
    if Val == TargetVal ->
            {CurrentDepth, ParentVal};
       true ->
            case find_info(Left, TargetVal, CurrentDepth + 1, Val) of
                nil ->
                    find_info(Right, TargetVal, CurrentDepth + 1, Val);
                Result ->
                    Result
            end
    end.