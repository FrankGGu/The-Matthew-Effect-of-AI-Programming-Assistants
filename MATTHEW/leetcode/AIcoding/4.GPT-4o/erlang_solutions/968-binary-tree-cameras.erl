-module(solution).
-export([min_camera_cover/1]).

-record(node, {val, left = none, right = none}).

min_camera_cover(Root) ->
    case count_cameras(Root) of
        {Cameras, covered} -> Cameras;
        {Cameras, uncovered} -> Cameras + 1
    end.

count_cameras(none) -> {0, covered};
count_cameras(#node{left=Left, right=Right}) ->
    {LeftCams, LeftState} = count_cameras(Left),
    {RightCams, RightState} = count_cameras(Right),
    case {LeftState, RightState} of
        {uncovered, uncovered} -> {LeftCams + RightCams + 1, covered};
        {uncovered, covered} -> {LeftCams + RightCams, covered};
        {covered, uncovered} -> {LeftCams + RightCams, covered};
        {covered, covered} -> {LeftCams + RightCams, uncovered}
    end.

covered -> 0.
uncovered -> 1.