-module(solution).
-export([max_depth/1]).

-record(node, {children = []}).

max_depth(nil) -> 0;
max_depth(#node{children = Children}) ->
    lists:foldl(fun(Node, Acc) -> max(max_depth(Node), Acc) end, 0, Children) + 1.