-module(solution).
-export([max_depth/1]).

max_depth(null) ->
    0;
max_depth({node, _Val, Children}) ->
    1 + max_depth_children(Children).

max_depth_children([]) ->
    0;
max_depth_children(Children) ->
    lists:foldl(fun(Child, Acc) ->
                    max(Acc, max_depth(Child))
                end, 0, Children).