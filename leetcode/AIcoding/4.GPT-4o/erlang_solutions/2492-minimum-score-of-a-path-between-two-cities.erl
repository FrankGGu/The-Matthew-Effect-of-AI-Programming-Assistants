-module(solution).
-export([min_score_path/3]).

-record(edge, {to, score}).

min_score_path(N, roads, start, end) ->
    Graph = build_graph(roads),
    bfs(Graph, start, end, N).

build_graph(Roads) ->
    Graph = maps:empty(),
    lists:foldl(fun({u, v, w}, Acc) ->
        Acc1 = maps:update_with(u, fun(X) -> [#edge{to = v, score = w} | X] end, [#edge{to = v, score = w}], Acc),
        maps:update_with(v, fun(X) -> [#edge{to = u, score = w} | X] end, [#edge{to = u, score = w}], Acc1)
    end, Graph, Roads).

bfs(Graph, Start, End, N) ->
    Queue = [{Start, infinity}],
    Visited = maps:put(Start, true, maps:empty()),
    bfs_helper(Graph, Queue, Visited, End, infinity).

bfs_helper(_, [], _, _, MinScore) ->
    MinScore;
bfs_helper(Graph, [{Node, Min} | Rest], Visited, End, CurrentMin) ->
    if
        Node =:= End ->
            min(Min, CurrentMin);
        true ->
            Edges = maps:get(Node, Graph, []),
            NewVisited = lists:foldl(fun(#edge{to = Next, score = Score}, Acc) ->
                if
                    maps:is_key(Next, Acc) -> Acc;
                    true -> 
                        NewMin = min(Score, Min),
                        [{Next, NewMin} | Acc]
                end
            end, Visited, Edges),
            bfs_helper(Graph, Rest ++ lists:sort(NewVisited), NewVisited, End, CurrentMin)
    end.