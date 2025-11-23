-module(min_distance_between_bst_nodes).
-export([min_diff/1]).

-record(bst_node, {val, left, right}).

min_diff(undefined) -> 0;
min_diff(Node) ->
    {Min, _} = inorder_traversal(Node, []),
    Min.

inorder_traversal(undefined, Acc) ->
    {lists:min(Acc), Acc};
inorder_traversal(#bst_node{val=Val, left=Left, right=Right}, Acc) ->
    {MinLeft, AccLeft} = inorder_traversal(Left, Acc),
    {MinRight, AccRight} = inorder_traversal(Right, [Val | AccLeft]),
    Min = min(MinLeft, MinRight),
    case AccRight of
        [] -> {Min, [Val | AccLeft]};
        _ -> {Min, [Val | AccLeft]}
    end.