-module(shortest_path_all_nodes).
-export([shortest_path_length/1]).

shortest_path_length(Graph) ->
    N = length(Graph),
    AllVisited = (1 bsl N) - 1,
    Queue = queue:new(),
    Dist = array:new(N * (1 bsl N), {infinity, -1}),

    % Initialize the queue and distances
    for(I <- 0 to N - 1) do
        queue:in({I, 1 bsl I, 0}, Queue),
        array:set(I + I * (1 bsl N), Dist, {0, I})
    end,

    bfs(Graph, Queue, Dist, AllVisited).

bfs(Graph, Queue, Dist, AllVisited) ->
    case queue:out(Queue) of
        {{value, {Node, Mask, Distance}}, NewQueue} ->
            if Mask == AllVisited then
                Distance
            else
                Neighbors = lists:nth(Node + 1, Graph),
                lists:foldl(
                    fun(Neighbor, AccQueue) ->
                        NewMask = Mask bor (1 bsl Neighbor),
                        Index = Neighbor + NewMask * length(Graph),
                        {CurrentDistance, _PrevNode} = array:get(Index, Dist),
                        if Distance + 1 < CurrentDistance then
                            array:set(Index, Dist, {Distance + 1, Node}),
                            queue:in({Neighbor, NewMask, Distance + 1}, AccQueue)
                        else
                            AccQueue
                        end
                    end,
                    NewQueue,
                    Neighbors
                ),
                bfs(Graph, NewQueue, Dist, AllVisited);
        empty ->
            infinity
    end.

-define(infinity, 999999).