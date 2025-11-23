-spec is_bipartite(Graph :: [[integer()]]) -> boolean().
is_bipartite(Graph) ->
    N = length(Graph),
    Colors = array:new([{size, N}, {default, -1}]),
    lists:all(fun(I) ->
        case array:get(I, Colors) of
            -1 -> bfs(Graph, Colors, I);
            _ -> true
        end
    end, lists:seq(0, N - 1)).

bfs(Graph, Colors, Start) ->
    Queue = queue:new(),
    Queue1 = queue:in(Start, Queue),
    Colors1 = array:set(Start, 0, Colors),
    bfs_loop(Graph, Queue1, Colors1).

bfs_loop(Graph, Queue, Colors) ->
    case queue:is_empty(Queue) of
        true -> true;
        false ->
            {{value, U}, Queue1} = queue:out(Queue),
            lists:all(fun(V) ->
                case array:get(V, Colors) of
                    -1 ->
                        NewColor = 1 - array:get(U, Colors),
                        Queue2 = queue:in(V, Queue1),
                        Colors1 = array:set(V, NewColor, Colors),
                        bfs_loop(Graph, Queue2, Colors1);
                    Color ->
                        Color =/= array:get(U, Colors)
                end
            end, array:get(U, Graph))
    end.