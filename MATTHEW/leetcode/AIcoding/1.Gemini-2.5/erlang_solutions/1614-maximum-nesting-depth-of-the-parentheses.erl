-module(solution).
-export([maxDepth/1]).

maxDepth(S) ->
    max_depth_impl(string:to_list(S), 0, 0).

max_depth_impl([], _CurrentDepth, MaxDepth) ->
    MaxDepth;
max_depth_impl([$( | T], CurrentDepth, MaxDepth) ->
    NewCurrentDepth = CurrentDepth + 1,
    NewMaxDepth = max(MaxDepth, NewCurrentDepth),
    max_depth_impl(T, NewCurrentDepth, NewMaxDepth);
max_depth_impl([$) | T], CurrentDepth, MaxDepth) ->
    NewCurrentDepth = CurrentDepth - 1,
    max_depth_impl(T, NewCurrentDepth, MaxDepth);
max_depth_impl([_ | T], CurrentDepth, MaxDepth) ->
    max_depth_impl(T, CurrentDepth, MaxDepth).