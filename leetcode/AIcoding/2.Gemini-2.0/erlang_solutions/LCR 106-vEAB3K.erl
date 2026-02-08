-module(is_bipartite).
-export([is_bipartite/1]).

is_bipartite(Graph) ->
    N = length(Graph),
    Colors = lists:duplicate(N, 0),
    lists:all(fun(StartNode) ->
                      (lists:nth(StartNode + 1, Colors) == 0 andalso
                       bfs(Graph, StartNode, 1, Colors)) orelse
                       true
              end, lists:seq(0, N - 1)).

bfs(Graph, StartNode, Color, Colors) ->
    Queue = queue:new(),
    Queue1 = queue:in({StartNode, Color}, Queue),
    bfs_helper(Graph, Queue1, Colors).

bfs_helper(Graph, Queue, Colors) ->
    case queue:out(Queue) of
        {{value, {Node, Color}}, Queue2} ->
            case lists:nth(Node + 1, Colors) of
                0 ->
                    Colors1 = lists:nthtail(Node, lists:replace_nth(Node + 1, Color, Colors)),
                    Neighbors = lists:nth(Node + 1, Graph),
                    Queue3 = lists:foldl(fun(Neighbor, AccQueue) ->
                                                  queue:in({Neighbor, -Color}, AccQueue)
                                          end, Queue2, Neighbors),
                    bfs_helper(Graph, Queue3, Colors1);
                C when C == Color ->
                    bfs_helper(Graph, Queue2, Colors);
                _ ->
                    false
            end;
        {empty, _} ->
            true
    end.