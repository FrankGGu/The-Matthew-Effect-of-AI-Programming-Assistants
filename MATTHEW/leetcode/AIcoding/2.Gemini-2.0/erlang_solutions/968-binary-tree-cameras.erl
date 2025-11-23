-module(binary_tree_cameras).
-export([min_camera_cover/1]).

min_camera_cover(Root) ->
  {Cameras, _} = solve(Root),
  Cameras.

solve(null) ->
  {0, 0};
solve(Node) ->
  {LeftCameras, LeftCovered} = solve(Node@.left),
  {RightCameras, RightCovered} = solve(Node@.right),

  Uncovered = LeftCovered + RightCovered,
  Covered = min([LeftCameras + RightCovered + 1,
                 RightCameras + LeftCovered + 1]),
  WithCamera = LeftCameras + RightCameras + 1,

  {min([Covered, WithCamera]), Uncovered}.