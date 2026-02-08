-module(solution).
-export([find_shortest_cycle/1]).

find_shortest_cycle(Graph) ->
    N = length(Graph),
    MinCycle = lists:foldl(
        fun(Node, Acc) ->
            case bfs(Node, Graph, N) of
                infinity -> Acc;
                Len -> min(Acc, Len)
            end
        end,
        infinity,
        lists:seq(0, N - 1)
    ),
    case MinCycle of
        infinity -> -1;
        _ -> MinCycle
    end.

bfs(Start, Graph, N) ->
    Parent = array:new([{size, N}, {default, -1}]),
    Distance = array:new([{size, N}, {default, -1}]),
    Queue = queue:new(),
    Queue1 = queue:in({Start, -1}, Queue),
    Distance1 = array:set(Start, 0, Distance),
    bfs_loop(Queue1, Parent, Distance1, Graph, infinity).

bfs_loop(Queue, Parent, Distance, Graph, MinCycle) ->
    case queue:is_empty(Queue) of
        true -> MinCycle;
        false ->
            {{value, {Node, P}}, Queue1} = queue:out(Queue),
            Dist = array:get(Node, Distance),
            lists:foldl(
                fun(Neighbor, {Q, Par, Dis, MC}) ->
                    case array:get(Neighbor, Dis) of
                        -1 ->
                            Q1 = queue:in({Neighbor, Node}, Q),
                            Dis1 = array:set(Neighbor, Dist + 1, Dis),
                            Par1 = array:set(Neighbor, Node, Par),
                            {Q1, Par1, Dis1, MC};
                        D ->
                            if
                                Neighbor =/= P ->
                                    CycleLen = D + Dist + 1,
                                    {Q, Par, Dis, min(MC, CycleLen)};
                                true -> {Q, Par, Dis, MC}
                            end
                    end
                end,
                {Queue1, Parent, Distance, MinCycle},
                array:get(Node, Graph)
            )
    end.