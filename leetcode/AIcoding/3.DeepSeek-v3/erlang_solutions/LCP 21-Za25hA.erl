-module(solution).
-export([chase_game/2]).

chase_game(edges, start) ->
    N = length(edges),
    Adj = lists:foldl(fun([U, V], Acc) ->
                          dict:append(U, V, dict:append(V, U, Acc))
                      end, dict:new(), edges),
    case find_cycle(Adj, N) of
        false -> 
            max_distance(Adj, start, N);
        Cycle ->
            CycleNodes = sets:from_list(Cycle),
            case sets:is_element(start, CycleNodes) of
                true -> -1;
                false ->
                    D1 = distance_to_cycle(Adj, start, CycleNodes, N),
                    CycleLen = length(Cycle),
                    if
                        D1 >= CycleLen -> -1;
                        true -> CycleLen
                    end
            end
    end.

find_cycle(Adj, N) ->
    Visited = array:new([{size, N + 1}, {default, false}]),
    Parent = array:new([{size, N + 1}, {default, -1}]),
    case dfs_cycle(1, -1, Adj, Visited, Parent) of
        {true, Cycle} -> Cycle;
        false -> false
    end.

dfs_cycle(Node, ParentNode, Adj, Visited, Parent) ->
    case array:get(Node, Visited) of
        true -> {true, find_cycle_path(Node, ParentNode, Parent)};
        false ->
            Visited1 = array:set(Node, true, Visited),
            Parent1 = array:set(Node, ParentNode, Parent),
            case dict:find(Node, Adj) of
                {ok, Neighbors} ->
                    lists:foldl(fun(Neighbor, Acc) ->
                        case Acc of
                            {true, _} -> Acc;
                            false ->
                                if
                                    Neighbor =/= ParentNode ->
                                        dfs_cycle(Neighbor, Node, Adj, Visited1, Parent1);
                                    true -> false
                                end
                        end
                    end, false, Neighbors);
                error -> false
            end
    end.

find_cycle_path(Node, ParentNode, Parent) ->
    Path = [Node],
    find_cycle_path_helper(ParentNode, Node, Parent, Path).

find_cycle_path_helper(Node, StartNode, Parent, Path) ->
    if
        Node =:= StartNode -> lists:reverse([StartNode | Path]);
        true ->
            ParentNode = array:get(Node, Parent),
            find_cycle_path_helper(ParentNode, StartNode, Parent, [Node | Path])
    end.

max_distance(Adj, Start, N) ->
    Visited = array:new([{size, N + 1}, {default, false}]),
    Distance = array:new([{size, N + 1}, {default, 0}]),
    Q = queue:in(Start, queue:new()),
    Visited1 = array:set(Start, true, Visited),
    bfs_max_distance(Q, Adj, Visited1, Distance).

bfs_max_distance(Q, Adj, Visited, Distance) ->
    case queue:out(Q) of
        {empty, _} -> 
            array:foldl(fun(_, D, Max) -> max(D, Max) end, 0, Distance);
        {{value, Node}, Q1} ->
            case dict:find(Node, Adj) of
                {ok, Neighbors} ->
                    {Q2, Visited1, Distance1} = 
                        lists:foldl(fun(Neighbor, {QAcc, VAcc, DAcc}) ->
                            case array:get(Neighbor, VAcc) of
                                false ->
                                    VAcc1 = array:set(Neighbor, true, VAcc),
                                    DAcc1 = array:set(Neighbor, array:get(Node, DAcc) + 1, DAcc),
                                    {queue:in(Neighbor, QAcc), VAcc1, DAcc1};
                                true -> {QAcc, VAcc, DAcc}
                            end
                        end, {Q1, Visited, Distance}, Neighbors),
                    bfs_max_distance(Q2, Adj, Visited1, Distance1);
                error -> bfs_max_distance(Q1, Adj, Visited, Distance)
            end
    end.

distance_to_cycle(Adj, Start, CycleNodes, N) ->
    Visited = array:new([{size, N + 1}, {default, false}]),
    Distance = array:new([{size, N + 1}, {default, 0}]),
    Q = queue:in(Start, queue:new()),
    Visited1 = array:set(Start, true, Visited),
    bfs_distance_to_cycle(Q, Adj, Visited1, Distance, CycleNodes).

bfs_distance_to_cycle(Q, Adj, Visited, Distance, CycleNodes) ->
    case queue:out(Q) of
        {empty, _} -> 0;
        {{value, Node}, Q1} ->
            case sets:is_element(Node, CycleNodes) of
                true -> array:get(Node, Distance);
                false ->
                    case dict:find(Node, Adj) of
                        {ok, Neighbors} ->
                            {Q2, Visited1, Distance1} = 
                                lists:foldl(fun(Neighbor, {QAcc, VAcc, DAcc}) ->
                                    case array:get(Neighbor, VAcc) of
                                        false ->
                                            VAcc1 = array:set(Neighbor, true, VAcc),
                                            DAcc1 = array:set(Neighbor, array:get(Node, DAcc) + 1, DAcc),
                                            {queue:in(Neighbor, QAcc), VAcc1, DAcc1};
                                        true -> {QAcc, VAcc, DAcc}
                                    end
                                end, {Q1, Visited, Distance}, Neighbors),
                            bfs_distance_to_cycle(Q2, Adj, Visited1, Distance1, CycleNodes);
                        error -> bfs_distance_to_cycle(Q1, Adj, Visited, Distance, CycleNodes)
                    end
            end
    end.