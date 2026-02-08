-module(path_sum_iii).
-export([run/1]).

run(Root) ->
    path_sum(Root, 0, 0).

path_sum(nil, _, _) ->
    0;
path_sum(Node, Target, Current) ->
    {Val, Left, Right} = Node,
    NewCurrent = Current + Val,
    Count = if
        NewCurrent == Target -> 1;
        true -> 0
    end,
    Count + path_sum(Left, Target, NewCurrent) + path_sum(Right, Target, NewCurrent) + path_sum_subpaths(Node, Target, NewCurrent).

path_sum_subpaths(nil, _, _) ->
    0;
path_sum_subpaths(Node, Target, Current) ->
    {Val, Left, Right} = Node,
    NewCurrent = Current + Val,
    Count = if
        NewCurrent == Target -> 1;
        true -> 0
    end,
    Count + path_sum_subpaths(Left, Target, NewCurrent) + path_sum_subpaths(Right, Target, NewCurrent).