-spec possible_bipartition(N :: integer(), Dislikes :: [[integer()]]) -> boolean().
possible_bipartition(N, Dislikes) ->
    Graph = build_graph(N, Dislikes),
    Colors = array:new([{size, N + 1}, {default, -1}]),
    check_bipartition(Graph, Colors).

build_graph(N, Dislikes) ->
    Graph = array:new([{size, N + 1}, {default, []}]),
    lists:foldl(fun([U, V], Acc) ->
        Acc1 = array:set(U, [V | array:get(U, Acc)], Acc),
        array:set(V, [U | array:get(V, Acc1)], Acc1)
    end, Graph, Dislikes).

check_bipartition(Graph, Colors) ->
    case lists:any(fun(Node) ->
        array:get(Node, Colors) == -1 andalso not bfs(Node, Graph, Colors)
    end, lists:seq(1, array:size(Graph) - 1) of
        true -> false;
        false -> true
    end.

bfs(Start, Graph, Colors) ->
    Queue = queue:in(Start, queue:new()),
    Colors1 = array:set(Start, 0, Colors),
    bfs_loop(Queue, Graph, Colors1).

bfs_loop(Queue, Graph, Colors) ->
    case queue:out(Queue) of
        {empty, _} -> true;
        {{value, Node}, Q} ->
            Neighbors = array:get(Node, Graph),
            lists:foldl(fun(Neighbor, {QAcc, ColorsAcc, Valid}) ->
                case array:get(Neighbor, ColorsAcc) of
                    -1 ->
                        NewColor = 1 - array:get(Node, ColorsAcc),
                        NewColors = array:set(Neighbor, NewColor, ColorsAcc),
                        {queue:in(Neighbor, QAcc), NewColors, Valid};
                    Color ->
                        if
                            Color == array:get(Node, ColorsAcc) ->
                                {QAcc, ColorsAcc, false};
                            true ->
                                {QAcc, ColorsAcc, Valid}
                        end
                end
            end, {Q, Colors, true}, Neighbors),
            case Valid of
                false -> false;
                true -> bfs_loop(Q, Graph, Colors)
            end
    end.