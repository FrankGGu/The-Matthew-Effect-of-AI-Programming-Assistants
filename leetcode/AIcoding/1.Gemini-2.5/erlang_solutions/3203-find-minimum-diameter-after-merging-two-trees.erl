-module(solution).
-export([solve/4]).

solve(N1, Edges1, N2, Edges2) ->
    Adj1 = build_adj(N1, Edges1),
    Adj2 = build_adj(N2, Edges2),

    Diameter1 = get_diameter_from_adj(N1, Adj1),
    Diameter2 = get_diameter_from_adj(N2, Adj2),

    Eccentricities1 = get_all_eccentricities_from_adj(N1, Adj1),
    Eccentricities2 = get_all_eccentricities_from_adj(N2, Adj2),

    MinEcc1 = lists:min([Ecc || {_, Ecc} <- Eccentricities1]),
    MinEcc2 = lists:min([Ecc || {_, Ecc} <- Eccentricities2]),

    MergedPathDiameter = MinEcc1 + 1 + MinEcc2,

    lists:max([Diameter1, Diameter2, MergedPathDiameter]).

build_adj(_N, Edges) ->
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = maps:update_with(U, fun(List) -> [V | List] end, [], Acc),
                    maps:update_with(V, fun(List) -> [U | List] end, [], Acc1)
                end, maps:new(), Edges).

bfs(Adj, StartNode) ->
    Queue = [{StartNode, 0}],
    Visited = sets:new(),
    bfs_loop(Queue, Visited, StartNode, 0, Adj).

bfs_loop([], _Visited, FarthestNode, MaxDist, _Adj) ->
    {FarthestNode, MaxDist};
bfs_loop([{Node, Dist} | T], Visited, CurrentFarthestNode, CurrentMaxDist, Adj) ->
    case sets:is_element(Node, Visited) of
        true ->
            bfs_loop(T, Visited, CurrentFarthestNode, CurrentMaxDist, Adj);
        false ->
            NewVisited = sets:add_element(Node, Visited),
            {NextFarthestNode, NextMaxDist} =
                if Dist > CurrentMaxDist -> {Node, Dist};
                   true -> {CurrentFarthestNode, CurrentMaxDist}
                end,
            Neighbors = maps:get(Node, Adj, []),
            NewQueue = T ++ [{N, Dist + 1} || N <- Neighbors, not sets:is_element(N, NewVisited)],
            bfs_loop(NewQueue, NewVisited, NextFarthestNode, NextMaxDist, Adj)
    end.

get_diameter_from_adj(N, Adj) ->
    if N == 0 -> 0;
       N == 1 -> 0;
       true ->
            {FarthestFrom0, _} = bfs(Adj, 0),
            {_, Diameter} = bfs(Adj, FarthestFrom0),
            Diameter
    end.

get_all_eccentricities_from_adj(N, Adj) ->
    if N == 0 -> [];
       N == 1 -> [{0, 0}];
       true ->
            Root = 0,
            InitialState1 = #{down_max1 => maps:new(), down_max2 => maps:new()},
            FinalState1 = dfs1_state(Root, -1, Adj, InitialState1),

            InitialUpMap = maps:put(Root, 0, maps:new()),
            InitialState2 = maps:put(up_max, InitialUpMap, FinalState1),
            FinalState = dfs2_state(Root, -1, Adj, InitialState2),

            lists:foldl(fun(Node, Acc) ->
                            Ecc = max(maps:get(Node, maps:get(down_max1, FinalState), 0),
                                      maps:get(Node, maps:get(up_max, FinalState), 0)),
                            [{Node, Ecc} | Acc]
                        end, [], lists:seq(0, N-1))
    end.

dfs1_state(Node, Parent, Adj, State) ->
    Neighbors = maps:get(Node, Adj, []),
    Children = [C || C <- Neighbors, C /= Parent],

    UpdatedState = lists:foldl(fun(Child, AccState) ->
                                   dfs1_state(Child, Node, Adj, AccState)
                               end, State, Children),

    ChildPaths = lists:map(fun(Child) -> 1 + maps:get(Child, maps:get(down_max1, UpdatedState), 0) end, Children),
    SortedChildPaths = lists:sort(fun(A, B) -> A >= B end, ChildPaths),

    NodeDownMax1 = case SortedChildPaths of
                       [H | _] -> H;
                       [] -> 0
                   end,
    NodeDownMax2 = case SortedChildPaths of
                       [_ , H2 | _] -> H2;
                       _ -> 0
                   end,

    maps:put(down_max1, maps:put(Node, NodeDownMax1, maps:get(down_max1, UpdatedState)),
             maps:put(down_max2, maps:put(Node, NodeDownMax2, maps:get(down_max2, UpdatedState)),
                      UpdatedState)).

dfs2_state(Node, Parent, Adj, State) ->
    Neighbors = maps:get(Node, Adj, []),
    Children = [C || C <- Neighbors, C /= Parent],

    CurrentUpMax = maps:get(Node, maps:get(up_max, State), 0),

    UpdatedState = lists:foldl(fun(Child, AccState) ->
                                   ChildDownMax1 = maps:get(Child, maps:get(down_max1, AccState), 0),
                                   NodeDownMax1 = maps:get(Node, maps:get(down_max1, AccState), 0),
                                   NodeDownMax2 = maps:get(Node, maps:get(down_max2, AccState), 0),

                                   ValueFromSiblings =
                                       if 1 + ChildDownMax1 == NodeDownMax1 ->
                                           NodeDownMax2;
                                       true ->
                                           NodeDownMax1
                                       end,

                                   ChildUpMaxVal = max(1 + CurrentUpMax, 1 + ValueFromSiblings),

                                   NewUpMap = maps:put(Child, ChildUpMaxVal, maps:get(up_max, AccState)),
                                   dfs2_state(Child, Node, Adj, maps:put(up_max, NewUpMap, AccState))
                               end, State, Children),
    UpdatedState.