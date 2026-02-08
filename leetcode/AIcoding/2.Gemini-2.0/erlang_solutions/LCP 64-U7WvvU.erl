-module(solution).
-export([solve/1]).

solve(Root) ->
  lights(Root, true).

lights(null, _) ->
  {0, false};
lights(Node, ParentOn) ->
  {LeftLights, LeftCovered} = lights(Node#node.left, false),
  {RightLights, RightCovered} = lights(Node#node.right, false),
  if
    ParentOn ->
      {LeftLights + RightLights, true};
    LeftCovered andalso RightCovered ->
      {LeftLights + RightLights, false};
    true ->
      {LeftLights + RightLights + 1, true}
  end.