-module(modify_graph_edge_weights).
-export([modifyEdgeWeights/2]).

modifyEdgeWeights(Edges, Node) ->
    modifyEdgeWeights(Edges, Node, []).

modifyEdgeWeights([], _, Acc) ->
    lists:reverse(Acc);
modifyEdgeWeights([[A, B, W] | T], Node, Acc) ->
    case A of
        Node -> modifyEdgeWeights(T, Node, [[Node, B, W] | Acc]);
        _ ->
            case B of
                Node -> modifyEdgeWeights(T, Node, [[A, Node, W] | Acc]);
                _ -> modifyEdgeWeights(T, Node, [[A, B, W] | Acc])
            end
    end.