-module(solution).
-export([count_valid_paths/2]).

-record(node, {val, children}).

count_valid_paths(Tree, Target) ->
    count_paths(Tree, Target, 0).

count_paths(nil, _, _) -> 0;
count_paths(Node, Target, Sum) ->
    NewSum = Sum + Node#node.val,
    if
        NewSum == Target -> 1 + lists:sum(map(fun(X) -> count_paths(X, Target, NewSum) end, Node#node.children));
        NewSum < Target -> lists:sum(map(fun(X) -> count_paths(X, Target, NewSum) end, Node#node.children));
        true -> 0
    end.