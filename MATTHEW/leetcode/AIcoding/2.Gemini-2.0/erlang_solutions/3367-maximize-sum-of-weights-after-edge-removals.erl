-module(maximize_sum_weights).
-export([maximum_value_of_edges/2]).

maximum_value_of_edges(N, Edges) ->
    maximum_value_of_edges(N, Edges, []).

maximum_value_of_edges(N, Edges, Removed) ->
    case length(Removed) of
        N - 1 ->
            EdgesSum = lists:sum([Weight || {_, _, Weight} <- Edges]),
            io:format("~w~n", [EdgesSum]),
            EdgesSum;
        _ ->
            MaxVal = lists:max(
                [
                    maximum_value_of_edges(N, lists:delete(Edge, Edges), Removed ++ [Edge])
                 || Edge <- Edges
                ]
            ),
            MaxVal
    end.