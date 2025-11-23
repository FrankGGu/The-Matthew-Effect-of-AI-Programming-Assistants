-module(solution).
-export([min_camera_cover/1]).

-record(node, {val, left = none, right = none}).

min_camera_cover(Root) ->
    case min_camera_cover_helper(Root) of
        {0, 1} -> 1; % Root needs a camera
        {0, 0} -> 0; % Root is covered
        {1, _} -> 1  % Root has a camera
    end.

min_camera_cover_helper(none) -> {0, 0};
min_camera_cover_helper(#node{left=Left, right=Right}) ->
    {LeftCams, LeftState} = min_camera_cover_helper(Left),
    {RightCams, RightState} = min_camera_cover_helper(Right),
    case {LeftState, RightState} of
        {0, 0} -> {LeftCams + RightCams + 1, 1}; % Need a camera
        {_, 1} -> {LeftCams + RightCams, 0}; % Covered by child camera
        {1, _} -> {LeftCams + RightCams, 0}; % Covered by child camera
        {_, _} -> {LeftCams + RightCams, 0}  % Covered by both children
    end.