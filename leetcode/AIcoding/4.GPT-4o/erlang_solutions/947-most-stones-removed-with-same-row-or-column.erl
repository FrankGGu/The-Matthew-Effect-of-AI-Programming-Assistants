-module(solution).
-export([remove_stones/1]).

remove_stones(Positions) ->
    Graph = build_graph(Positions),
    Components = connected_components(Graph),
    Sum = lists:sum(lists:map(fun(X) -> length(X) - 1 end, Components)),
    Sum.

build_graph(Positions) ->
    lists:foldl(fun({X, Y}, Acc) ->
        NewAcc = maps:put(X, [Y | maps:get(X, Acc, [])]),
        lists:foldl(fun({X1, Y1}) -> 
            if 
                X1 =:= X -> NewAcc;
                Y1 =:= Y -> maps:put(X1, [Y | maps:get(X1, NewAcc, [])]);
                true -> NewAcc
            end
        end, NewAcc, Positions)
    end, #{}, Positions).

connected_components(Graph) ->
    lists:foldl(fun({K, V}, Acc) ->
        if
            maps:is_key(K, Acc) -> Acc;
            true -> [dfs(K, Graph, []) | Acc]
        end
    end, [], maps:to_list(Graph)).

dfs(Node, Graph, Visited) ->
    if
        lists:member(Node, Visited) -> Visited;
        true ->
            neighbors = maps:get(Node, Graph, []),
            NewVisited = [Node | Visited],
            lists:foldl(fun(N, Acc) -> dfs(N, Graph, Acc) end, NewVisited, neighbors)
    end.