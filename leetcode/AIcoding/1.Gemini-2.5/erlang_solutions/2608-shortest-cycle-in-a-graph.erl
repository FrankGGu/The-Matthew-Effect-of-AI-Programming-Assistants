-module(solution).
-export([shortestCycle/2]).

shortestCycle(N, Edges) ->
    Adj = build_adj_list(N, Edges),
    MinCycle = find_shortest_cycle_bfs(N, Adj),
    case MinCycle of
        infinity -> -1;
        _ -> MinCycle
    end.

build_adj_list(N, Edges) ->
    Adj = array:new([{size, N}, {fixed, true}, {default, []}]),
    lists:foldl(fun([U, V], AccAdj) ->
                        Acc1 = array:set(U, [V | array:get(U, AccAdj)], AccAdj),
                        array:set(V, [U | array:get(V, Acc1)], Acc1)
                end, Adj, Edges).

find_shortest_cycle_bfs(N, Adj) ->
    MinCycle = lists:foldl(fun(StartNode, AccMinCycle) ->
                                   bfs_from_node(StartNode, N, Adj, AccMinCycle)
                           end, infinity, lists:seq(0, N - 1)),
    MinCycle.

bfs_from_node(StartNode, N, Adj, CurrentMinCycle) ->
    Dist = array:new([{size, N}, {fixed, true}, {default, -1}]), % -1 means unvisited
    Parent = array:new([{size, N}, {fixed, true}, {default, -1}]), % -1 means no parent or start node

    Dist1 = array:set(StartNode, 0, Dist),
    Q = queue:in(StartNode, queue:new()),

    bfs_loop(Q, Dist1, Parent, Adj, CurrentMinCycle).

bfs_loop(Q, Dist, Parent, Adj, CurrentMinCycle) ->
    case queue:out(Q) of
        {{value, U}, Q1} ->
            Neighbors = array:get(U, Adj),
            {NewQ, NewDist, NewParent, NewMinCycle} = 
                lists:foldl(fun(V, {AccQ, AccDist, AccParent, AccMinCycle}) ->
                                    DistV = array:get(V, AccDist),
                                    ParentU = array:get(U, AccParent),

                                    case DistV of
                                        -1 -> % V is unvisited
                                            NewDistV = array:set(V, array:get(U, AccDist) + 1, AccDist),
                                            NewParentV = array:set(V, U, AccParent),
                                            {queue:in(V, AccQ), NewDistV, NewParentV, AccMinCycle};
                                        _ when V =/= ParentU -> % V is visited and not parent of U, cycle found
                                            CycleLen = array:get(U, AccDist) + DistV + 1,
                                            {AccQ, AccDist, AccParent, min(AccMinCycle, CycleLen)};
                                        _ -> % V is parent of U, ignore
                                            {AccQ, AccDist, AccParent, AccMinCycle}
                                    end
                            end, {Q1, Dist, Parent, CurrentMinCycle}, Neighbors),
            bfs_loop(NewQ, NewDist, NewParent, NewMinCycle);
        {empty, _} ->
            CurrentMinCycle
    end.