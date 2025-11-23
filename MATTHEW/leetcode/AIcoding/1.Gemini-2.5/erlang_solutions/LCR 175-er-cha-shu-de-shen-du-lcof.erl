-module(solution).
-export([max_depth/1]).

max_depth(null) ->
    0;
max_depth({node, _Val, Left, Right}) ->
    1 + max(max_depth(Left), max_depth(Right)).