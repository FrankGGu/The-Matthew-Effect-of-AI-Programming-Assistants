-module(solution).
-export([minCameraCover/1]).

minCameraCover(Root) ->
    {State, Cameras} = dfs(Root),
    case State of
        0 -> Cameras + 1;
        _ -> Cameras
    end.

dfs(nil) ->
    {2, 0};
dfs({node, _, Left, Right}) ->
    {LeftState, LeftCameras} = dfs(Left),
    {RightState, RightCameras} = dfs(Right),

    TotalCameras = LeftCameras + RightCameras,

    case {LeftState, RightState} of
        {0, _} ->
            {1, TotalCameras + 1};
        {_, 0} ->
            {1, TotalCameras + 1};
        {1, _} ->
            {2, TotalCameras};
        {_, 1} ->
            {2, TotalCameras};
        _ ->
            {0, TotalCameras}
    end.