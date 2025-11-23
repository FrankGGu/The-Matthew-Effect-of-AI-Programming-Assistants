-module(chase_game).
-export([chase_game/2]).

chase_game(graph, start_a, start_b) ->
    N = length(graph),
    {ok, Max_A_Distance} = max_distance(graph, start_a, N),
    {ok, B_Distance} = distance(graph, start_b),

    case lists:all(fun(Node) -> maps:get(Node, B_Distance) >= maps:get(Node, Max_A_Distance) end, lists:seq(1, N)) of
        true ->
            true;
        false ->
            false
    end.

max_distance(graph, start_node, N) ->
    Max_Distance_Map = lists:foldl(fun(Node, Acc) ->
                                        {ok, Distance} = distance(graph, Node),
                                        maps:put(Node, maps:get(start_node, Distance), Acc)
                                    end, #{}, lists:seq(1,N)),

    Max_Distance = lists:max(maps:values(Max_Distance_Map)),

    Max_Nodes = lists:filter(fun(Node) -> maps:get(Node, Max_Distance_Map) == Max_Distance end, maps:keys(Max_Distance_Map)),

    case is_reachable(graph, start_node, Max_Nodes) of
        true ->
            {ok, #{Node => Max_Distance || Node <- lists:seq(1, N)}};
        false ->
            {error, unreachable}
    end.

is_reachable(graph, start_node, target_nodes) ->
    Visited = bfs(graph, start_node, target_nodes, []).

    lists:any(fun(Node) -> lists:member(Node, Visited) end, target_nodes).

bfs(graph, start_node, target_nodes, Visited) ->
    bfs([start_node], graph, target_nodes, Visited).

bfs([], _Graph, _Target_Nodes, Visited) ->
    Visited;

bfs([Node | Rest], Graph, Target_Nodes, Visited) ->
    case lists:member(Node, Visited) of
        true ->
            bfs(Rest, Graph, Target_Nodes, Visited);
        false ->
            Neighbors = maps:get(Node, Graph, []),
            bfs(Rest ++ Neighbors, Graph, Target_Nodes, [Node | Visited])
    end.

distance(graph, start_node) ->
    N = length(graph),
    Queue = [{start_node, 0}],
    Visited = [start_node],
    Distance = #{start_node => 0},

    distance_loop(Queue, graph, Visited, Distance, N).

distance_loop([], _Graph, _Visited, Distance, _N) ->
    {ok, maps:from_list([{I, maps:get(I, Distance, infinity)} || I <- lists:seq(1, length(Distance))])};

distance_loop([{Node, Dist} | Rest], Graph, Visited, Distance, N) ->
    Neighbors = maps:get(Node, Graph, []),
    New_Neighbors = lists:filter(fun(Neighbor) -> not lists:member(Neighbor, Visited) end, Neighbors),

    New_Queue = Rest ++ lists:map(fun(Neighbor) -> {Neighbor, Dist + 1} end, New_Neighbors),
    New_Visited = Visited ++ New_Neighbors,
    New_Distance = lists:foldl(fun(Neighbor, Acc) -> maps:put(Neighbor, Dist + 1, Acc) end, Distance, New_Neighbors),

    distance_loop(New_Queue, Graph, New_Visited, New_Distance, N).