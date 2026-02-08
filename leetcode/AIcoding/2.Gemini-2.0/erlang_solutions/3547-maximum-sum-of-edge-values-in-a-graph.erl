-module(max_edge_sum).
-export([maximum_sum/1]).

maximum_sum(edges) ->
    maximum_sum(edges, []).

maximum_sum([], Acc) ->
    lists:sum(Acc);
maximum_sum([H|T], Acc) ->
    [U, V, W] = H,
    maximum_sum(T, [W|Acc]).