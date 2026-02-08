-module(solution).
-export([modify_graph_edge_weights/2]).

modify_graph_edge_weights(N, Edges) ->
    modify_graph_edge_weights(N, Edges, []).

modify_graph_edge_weights(_, [], Acc) ->
    lists:reverse(Acc);
modify_graph_edge_weights(N, [{U, V, W} | T], Acc) ->
    NewW = if
        W < 0 -> W;
        W >= N -> W - 1;
        true -> W + 1
    end,
    modify_graph_edge_weights(N, T, [{U, V, NewW} | Acc]).