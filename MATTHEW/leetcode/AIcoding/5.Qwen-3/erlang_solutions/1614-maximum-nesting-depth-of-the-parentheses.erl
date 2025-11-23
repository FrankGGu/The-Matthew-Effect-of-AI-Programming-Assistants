-module(max_depth).
-export([max_depth/1]).

max_depth(S) ->
    max_depth(S, 0, 0).

max_depth([], _, Max) ->
    Max;
max_depth([$( | T], Current, Max) ->
    max_depth(T, Current + 1, max(Max, Current + 1));
max_depth([$) | T], Current, Max) ->
    max_depth(T, Current - 1, Max);
max_depth([_ | T], Current, Max) ->
    max_depth(T, Current, Max).