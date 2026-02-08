-module(solution).
-export([count_restricted_paths/2]).

count_restricted_paths(N, edges) ->
    Graph = build_graph(N, edges),
    Distances = dijkstra(Graph, N),
    count_paths(Graph, 1, N, Distances, #{1 => 1}).

build_graph(N, Edges) ->
    lists:foldl(fun({U, V, W}, Acc) ->
        MapU = maps:update_with(U, fun(X) -> [{V, W} | X] end, [{V, W}], Acc),
        MapV = maps:update_with(V, fun(X) -> [{U, W} | X] end, [{U, W}], MapU)
    end, maps:new(), Edges).

dijkstra(Graph, Start) ->
    Queue = [{0, Start}],
    dijkstra_helper(Graph, Queue, maps:new(), maps:put(Start, 0, maps:new())).

dijkstra_helper(_, [], Distances, Distances) ->
    Distances;
dijkstra_helper(Graph, [{Cost, Node} | Rest], Distances, Visited) ->
    case maps:is_key(Node, Visited) of
        true ->
            dijkstra_helper(Graph, Rest, Distances, Visited);
        false ->
            NewVisited = maps:put(Node, Cost, Visited),
            Edges = maps:get(Node, Graph, []),
            NewQueue = lists:foldl(fun({Next, Weight}, Acc) ->
                NewCost = Cost + Weight,
                case maps:get(Next, NewVisited, infinity) > NewCost of
                    true -> [{NewCost, Next} | Acc];
                    false -> Acc
                end
            end, Rest, Edges),
            dijkstra_helper(Graph, NewQueue, Distances, NewVisited)
    end.

count_paths(_, Node, Node, _, Memo) ->
    maps:get(Node, Memo, 0);
count_paths(Graph, Current, Target, Distances, Memo) ->
    case maps:is_key(Current, Memo) of
        true -> maps:get(Current, Memo, 0);
        false ->
            Paths = lists:foldl(fun({Next, _}, Acc) ->
                if 
                    maps:get(Next, Distances, infinity) < maps:get(Current, Distances, infinity) -> 
                        Acc + count_paths(Graph, Next, Target, Distances, Memo);
                    true -> Acc
                end
            end, 0, maps:get(Current, Graph)),
            NewMemo = maps:put(Current, Paths, Memo),
            Paths
    end.