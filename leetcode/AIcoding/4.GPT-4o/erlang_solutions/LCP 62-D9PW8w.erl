-module(solution).
-export([find_central_node/2]).

find_central_node(N, Edges) ->
    Graph = build_graph(N, Edges),
    find_central(Graph, N).

build_graph(N, Edges) ->
    lists:foldl(fun({X, Y}, Acc) ->
        maps:update_with(X, fun(List) -> [Y | List] end, [Y], Acc)
    end, maps:fold(fun(_, _, Acc) -> Acc + 1 end, 0, Edges), Edges).

find_central(Graph, N) ->
    lists:foldl(fun(Node, {MinDist, CentralNode}) ->
        Dist = calculate_distance(Graph, Node, N),
        if
            Dist < MinDist -> {Dist, Node};
            true -> {MinDist, CentralNode}
        end
    end, {infinity, -1}, maps:keys(Graph)).

calculate_distance(Graph, Node, N) ->
    bfs([{Node, 0}], maps:fold(fun(_, _, Acc) -> Acc + 1 end, 0, Graph), maps:map(fun(_, _) -> false end, Graph)).

bfs([], _, _) -> 0;
bfs([{Node, Dist} | Rest], MaxDist, Visited) ->
    if
        maps:get(Node, Visited) -> bfs(Rest, MaxDist, Visited);
        true ->
            NewVisited = maps:put(Node, true, Visited),
            NewDist = Dist + 1,
            NewRest = lists:foldl(fun(Neighbor, Acc) ->
                case maps:get(Neighbor, NewVisited, false) of
                    false -> [{Neighbor, NewDist} | Acc];
                    _ -> Acc
                end
            end, Rest, maps:get(Node, Graph)),
            bfs(NewRest, MaxDist, NewVisited)
    end.