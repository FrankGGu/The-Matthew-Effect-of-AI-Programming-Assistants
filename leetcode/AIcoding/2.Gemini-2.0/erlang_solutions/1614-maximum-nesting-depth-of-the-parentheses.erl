-module(maximum_nesting_depth).
-export([max_depth/1]).

max_depth(S) ->
  max_depth_helper(S, 0, 0).

max_depth_helper([], Depth, MaxDepth) ->
  max(Depth, MaxDepth);
max_depth_helper([$( | T], Depth, MaxDepth) ->
  max_depth_helper(T, Depth + 1, max(Depth + 1, MaxDepth));
max_depth_helper([$) | T], Depth, MaxDepth) ->
  max_depth_helper(T, Depth - 1, max(Depth - 1, MaxDepth));
max_depth_helper([_ | T], Depth, MaxDepth) ->
  max_depth_helper(T, Depth, MaxDepth).

max(A, B) ->
  if A > B -> A;
  true -> B
  end.