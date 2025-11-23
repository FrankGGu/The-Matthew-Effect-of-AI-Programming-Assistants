-module(shortest_cycle_in_graph).
-export([run/1]).

run(Graph) ->
    N = length(Graph),
    MinCycle = infinity,
    lists:foreach(fun(I) -> 
        lists:foreach(fun(J) -> 
            if I /= J ->
                Dist = bfs(Graph, I, J),
                if Dist /= infinity ->
                    MinCycle = min(MinCycle, Dist + 1);
                true -> ok
                end;
            true -> ok
            end
        end, lists:seq(0, N-1))
    end, lists:seq(0, N-1)),
    case MinCycle of
        infinity -> -1;
        _ -> MinCycle
    end.

bfs(Graph, Start, End) ->
    N = length(Graph),
    Visited = array:new(N, {default, false}),
    Queue = queue:from_list([{Start, 0}]),
    bfs_loop(Queue, Visited, End).

bfs_loop(Q, Visited, End) ->
    case queue:out(Q) of
        {empty, _} -> infinity;
        {{value, {Node, Dist}}, Q1} ->
            case array:get(Node, Visited) of
                true -> bfs_loop(Q1, Visited, End);
                false ->
                    NewVisited = array:set(Node, true, Visited),
                    case Node of
                        End -> Dist;
                        _ ->
                            Neighbors = lists:filter(fun(X) -> X /= Node end, lists:nth(Node+1, Graph)),
                            NewQueue = lists:foldl(fun(Neighbor, Acc) ->
                                queue:in({Neighbor, Dist+1}, Acc)
                            end, Q1, Neighbors),
                            bfs_loop(NewQueue, NewVisited, End)
                    end
            end
    end.