-module(solution).
-export([distance_k/3]).

-record(node, {val, left = null, right = null}).

distance_k(Root, K, _Node) ->
    Nodes = [],
    case Root of
        null -> Nodes;
        _ -> 
            Nodes1 = collect_nodes(Root, K, 0, Nodes),
            lists:flatmap(fun({_, Val}) -> [Val] end, Nodes1)
    end.

collect_nodes(null, _, _, Nodes) -> Nodes;
collect_nodes(Node, K, Depth, Nodes) ->
    Nodes1 = [{Depth, Node#node.val} | Nodes],
    if
        Depth < K ->
            Nodes2 = collect_nodes(Node#node.left, K, Depth + 1, Nodes1),
            collect_nodes(Node#node.right, K, Depth + 1, Nodes2);
        true ->
            Nodes1
    end.