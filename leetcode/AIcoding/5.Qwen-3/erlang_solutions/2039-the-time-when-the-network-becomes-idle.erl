-module(solution).
-export([is_idle/1]).

is_idle(Edges) ->
    Nodes = lists:seq(0, length(Edges) - 1),
    Graph = build_graph(Edges),
    Time = bfs(Graph, 0),
    lists:max(Time) + 1.

build_graph(Edges) ->
    F = fun({A, B}, Acc) ->
            Acc#{A => [B | maps:get(A, Acc, [])], B => [A | maps:get(B, Acc, [])]}
        end,
    lists:foldl(F, #{}, Edges).

bfs(Graph, Start) ->
    Visited = maps:new(),
    Queue = queue:from_list([{Start, 0}]),
    bfs_helper(Graph, Visited, Queue, #{}).

bfs_helper(_, _, [], Result) ->
    Result;
bfs_helper(Graph, Visited, Queue, Result) ->
    { {Node, Dist}, NewQueue } = queue:out(Queue),
    case maps:is_key(Node, Result) of
        true ->
            bfs_helper(Graph, Visited, NewQueue, Result);
        false ->
            NewVisited = maps:put(Node, true, Visited),
            Neighbors = maps:get(Node, Graph, []),
            NewResult = maps:put(Node, Dist, Result),
            NewQueue2 = lists:foldl(fun(Neighbor, Q) ->
                                        if
                                            maps:is_key(Neighbor, NewVisited) -> Q;
                                            true -> queue:in({Neighbor, Dist + 1}, Q)
                                        end
                                    end, NewQueue, Neighbors),
            bfs_helper(Graph, NewVisited, NewQueue2, NewResult)
    end.