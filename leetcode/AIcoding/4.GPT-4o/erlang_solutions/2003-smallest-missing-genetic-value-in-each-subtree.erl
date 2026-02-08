-module(solution).
-export([smallestMissingValue/1]).

-record(node, {val, left = none, right = none}).

-smallestMissingValue(Tree) ->
    Nodes = traverse_tree(Tree, []),
    MissingValues = lists:map(fun(Node) -> find_smallest_missing(Node, Nodes) end, Nodes),
    MissingValues.

traverse_tree(none, Acc) -> Acc;
traverse_tree(#node{val=Val, left=Left, right=Right}, Acc) ->
    traverse_tree(Left, [Val | traverse_tree(Right, Acc)]).

find_smallest_missing(NodeValue, Nodes) ->
    Missing = lists:sort(lists:usort([1:lists:max(Nodes) ++ [NodeValue]])),
    lists:foldl(fun(X, Acc) -> if X == Acc + 1 -> Acc; true -> Acc + 1 end end, 0, Missing).