-module(solution).
-export([vertical_order_traversal/1]).

-record(tree_node, {val, left = null, right = null}).

vertical_order_traversal(Root) ->
    Nodes = [],
    Map = maps:empty(),
    traverse(Root, 0, 0, Nodes, Map).

traverse(null, _, _, Nodes, Map) -> 
    {Nodes, Map};
traverse(Node, X, Y, Nodes, Map) ->
    NewMap = maps:update_with(X, fun(List) -> [Node#tree_node.val | List] end, [Node#tree_node.val], Map),
    NewNodes = [{X, Y} | Nodes],
    {traverse(Node#tree_node.left, X - 1, Y + 1, NewNodes, NewMap),
     traverse(Node#tree_node.right, X + 1, Y + 1, NewNodes, NewMap)}.

vertical_order(Root) ->
    {Nodes, Map} = vertical_order_traversal(Root),
    SortedNodes = lists:usort(Nodes),
    lists:map(fun(X) -> maps:get(X, Map) end, SortedNodes).