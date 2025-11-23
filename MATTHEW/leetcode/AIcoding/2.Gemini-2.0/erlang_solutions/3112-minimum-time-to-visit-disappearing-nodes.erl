-module(minimum_time_to_visit_disappearing_nodes).
-export([minimum_time]).

minimum_time(N, Edges, NodeValues) ->
    Graph = create_graph(Edges),
    minimum_time_helper(1, N, Graph, NodeValues, 0, 0, []).

minimum_time_helper(Node, N, Graph, NodeValues, CurrentTime, Score, Visited) ->
    case lists:member(Node, Visited) of
        true ->
            minimum_time_helper(find_unvisited_neighbor(Node, Graph, Visited), N, Graph, NodeValues, CurrentTime + 1, Score, Visited ++ [Node]);
        false ->
            NewScore = Score + max(0, NodeValues - CurrentTime),
            case Node =:= N of
                true ->
                    NewScore;
                false ->
                    minimum_time_helper(find_unvisited_neighbor(Node, Graph, Visited), N, Graph, NodeValues, CurrentTime + 1, NewScore, Visited ++ [Node])
            end
    end.

find_unvisited_neighbor(Node, Graph, Visited) ->
    Neighbors = maps:get(Node, Graph, []),
    UnvisitedNeighbors = lists:filter(fun(Neighbor) -> not lists:member(Neighbor, Visited) end, Neighbors),
    case UnvisitedNeighbors of
        [] ->
            1;
        _ ->
            lists:nth(1, UnvisitedNeighbors)
    end.

create_graph(Edges) ->
    lists:foldl(fun({U, V}, Acc) ->
                        Acc1 = maps:update_with(U, fun(List) -> List ++ [V] end, [V], Acc),
                        maps:update_with(V, fun(List) -> List ++ [U] end, [U], Acc1)
                end, #{}, Edges).