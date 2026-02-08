-module(maximize_target_nodes).
-export([max_target_nodes/1]).

max_target_nodes(Root) ->
  {_, Res} = dfs(Root),
  Res.

dfs(null) ->
  {false, 0};
dfs({Val, Left, Right}) ->
  {LeftTake, LeftNotTake} = dfs(Left),
  {RightTake, RightNotTake} = dfs(Right),
  Take = 1 + LeftNotTake + RightNotTake,
  NotTake = max(LeftTake, LeftNotTake) + max(RightTake, RightNotTake),
  {true, max(Take, NotTake)}.