-module(solution).
-export([minCameraCover/1]).

-record(tree_node, {val = 0, left = nil, right = nil}).

minCameraCover(Root) ->
    case solve(Root) of
        {0, Count} -> Count + 1;
        {_, Count} -> Count
    end.

solve(nil) -> {1, 0}.

solve(#tree_node{left = Left, right = Right}) ->
    {LeftState, LeftCameras} = solve(Left),
    {RightState, RightCameras} = solve(Right),

    TotalCamerasFromChildren = LeftCameras + RightCameras,

    if
        LeftState == 0; RightState == 0 ->
            {2, TotalCamerasFromChildren + 1};
        LeftState == 2; RightState == 2 ->
            {1, TotalCamerasFromChildren};
        true ->
            {0, TotalCamerasFromChildren}
    end.