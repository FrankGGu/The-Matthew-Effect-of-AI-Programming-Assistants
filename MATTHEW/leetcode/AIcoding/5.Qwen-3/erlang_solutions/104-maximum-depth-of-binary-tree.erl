-module(solution).
-export([max_depth/1]).

max_depth(nil) -> 0;
max_depth({_, Left, Right}) ->
    1 + lists:max([max_depth(Left), max_depth(Right)]).