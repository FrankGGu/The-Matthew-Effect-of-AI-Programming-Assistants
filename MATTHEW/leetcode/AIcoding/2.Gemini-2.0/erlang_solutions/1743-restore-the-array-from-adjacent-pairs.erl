-module(restore_array).
-export([restore_array/1]).

restore_array(AdjacentPairs) ->
    graph(AdjacentPairs, G),
    start_node(G, Start),
    restore(Start, G, [], []).

graph(AdjacentPairs, G) ->
    lists:foldl(fun([U, V], Acc) ->
                        Acc#{U => lists:append(maps:get(U, Acc, []), [V]),
                              V => lists:append(maps:get(V, Acc, []), [U])}
                end, #{}, AdjacentPairs).

start_node(G, Start) ->
    lists:keyfind(1, 1, lists:map(fun({K, V}) -> {length(V), K} end, maps:to_list(G))).

restore(Node, G, Visited, Acc) ->
    if
        lists:member(Node, Visited) ->
            lists:reverse(Acc);
        true ->
            Neighbors = maps:get(Node, G),
            Next = lists:filter(fun(N) -> not lists:member(N, Visited) end, Neighbors),
            case Next of
                [] ->
                    lists:reverse([Node | Acc]);
                [N] ->
                    restore(N, G, [Node | Visited], [Node | Acc]);
                _ ->
                    erlang:error("Invalid graph")
            end
    end.