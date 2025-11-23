-spec is_bipartite(Graph :: [[integer()]]) -> boolean().
is_bipartite(Graph) ->
    N = length(Graph),
    Colors = array:new([{size, N}, {default, -1}]),
    try
        lists:foreach(
            fun(I) ->
                case array:get(I, Colors) of
                    -1 ->
                        case bfs(I, Graph, Colors) of
                            false -> throw(false);
                            _ -> ok
                        end;
                    _ -> ok
                end
            end,
            lists:seq(0, N - 1)
        ),
        true
    catch
        throw:false -> false
    end.

bfs(Start, Graph, Colors) ->
    Queue = queue:in(Start, queue:new()),
    Colors1 = array:set(Start, 0, Colors),
    bfs_loop(Queue, Graph, Colors1).

bfs_loop(Queue, Graph, Colors) ->
    case queue:out(Queue) of
        {empty, _} -> Colors;
        {{value, U}, Q} ->
            lists:foldl(
                fun(V, {QAcc, ColorsAcc}) ->
                    case array:get(V, ColorsAcc) of
                        -1 ->
                            NewColor = 1 - array:get(U, ColorsAcc),
                            NewColors = array:set(V, NewColor, ColorsAcc),
                            {queue:in(V, QAcc), NewColors};
                        Color ->
                            case Color =:= array:get(U, ColorsAcc) of
                                true -> throw(false);
                                false -> {QAcc, ColorsAcc}
                            end
                    end
                end,
                {Q, Colors},
                Graph ++ [[]]
            ),
            bfs_loop(Q, Graph, Colors)
    end.