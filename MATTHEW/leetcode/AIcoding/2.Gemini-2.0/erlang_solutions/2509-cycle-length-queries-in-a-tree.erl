-module(cycle_length_queries).
-export([cycle_length_queries/2]).

cycle_length_queries(N, Queries) ->
    lists:map(fun(Query) -> cycle_length(N, Query) end, Queries).

cycle_length(N, [Node1, Node2]) ->
    cycle_length_helper(Node1, Node2, 0).

cycle_length_helper(Node1, Node2, Count) ->
    if Node1 == Node2 ->
        Count + 1;
    true ->
        if Node1 > Node2 ->
            cycle_length_helper(Node1 div 2, Node2, Count + 1);
        true ->
            cycle_length_helper(Node1, Node2 div 2, Count + 1)
        end
    end.