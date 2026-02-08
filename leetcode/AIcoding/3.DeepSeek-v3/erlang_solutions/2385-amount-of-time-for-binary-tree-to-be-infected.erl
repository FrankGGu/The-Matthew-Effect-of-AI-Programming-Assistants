-spec amount_of_time(Root :: #tree_node{} | null, Start :: integer()) -> integer().
amount_of_time(Root, Start) ->
    case Root of
        null -> 0;
        _ ->
            Graph = build_graph(Root, #{}),
            {MaxTime, _} = bfs(Graph, Start, sets:new()),
            MaxTime
    end.

build_graph(null, Graph) -> Graph;
build_graph(#tree_node{val = Val, left = Left, right = Right}, Graph) ->
    Graph1 = case Left of
        null -> Graph;
        #tree_node{val = LeftVal} ->
            G1 = maps:put(Val, [LeftVal | maps:get(Val, Graph, [])], Graph),
            maps:put(LeftVal, [Val | maps:get(LeftVal, G1, [])], G1)
    end,
    Graph2 = case Right of
        null -> Graph1;
        #tree_node{val = RightVal} ->
            G2 = maps:put(Val, [RightVal | maps:get(Val, Graph1, [])], Graph1),
            maps:put(RightVal, [Val | maps:get(RightVal, G2, [])], G2)
    end,
    build_graph(Left, build_graph(Right, Graph2)).

bfs(Graph, Start, Visited) ->
    Queue = queue:in({Start, 0}, queue:new()),
    bfs_loop(Graph, Queue, Visited, 0).

bfs_loop(Graph, Queue, Visited, MaxTime) ->
    case queue:out(Queue) of
        {empty, _} -> {MaxTime, Visited};
        {{value, {Node, Time}}, Q} ->
            case sets:is_element(Node, Visited) of
                true -> bfs_loop(Graph, Q, Visited, MaxTime);
                false ->
                    Visited1 = sets:add_element(Node, Visited),
                    Neighbors = maps:get(Node, Graph, []),
                    Q1 = lists:foldl(fun(N, Acc) ->
                        queue:in({N, Time + 1}, Acc)
                    end, Q, Neighbors),
                    bfs_loop(Graph, Q1, Visited1, max(MaxTime, Time))
            end
    end.