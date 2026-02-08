-module(solution).
-export([findClosestNode/4]).

bfs(StartNode, N, EdgesArray) ->
    Distances = array:new([{size, N}, {fixed, true}, {default, -1}]),
    Q = queue:new(),
    Q1 = queue:in({StartNode, 0}, Q),
    bfs_loop(Q1, Distances, EdgesArray).

bfs_loop(Q, Distances, EdgesArray) ->
    case queue:out(Q) of
        {{value, {CurrentNode, CurrentDistance}}, Q_rest} ->
            case array:get(CurrentNode, Distances) of
                -1 ->
                    NewDistances = array:set(CurrentNode, CurrentDistance, Distances),
                    NextNode = array:get(CurrentNode, EdgesArray),
                    Q_next = if NextNode /= -1 -> queue:in({NextNode, CurrentDistance + 1}, Q_rest);
                                true -> Q_rest
                             end,
                    bfs_loop(Q_next, NewDistances, EdgesArray);
                _ ->
                    bfs_loop(Q_rest, Distances, EdgesArray)
            end;
        {empty, _} ->
            Distances
    end.

findClosestNode(N, EdgesList, Node1, Node2) ->
    EdgesArray = array:from_list(EdgesList),

    Distances1 = bfs(Node1, N, EdgesArray),
    Distances2 = bfs(Node2, N, EdgesArray),

    find_min_max_dist(0, N, Distances1, Distances2, 1_000_000, -1).

find_min_max_dist(CurrentNode, N, Distances1, Distances2, MinMaxDist, ResultNode) when CurrentNode < N ->
    D1 = array:get(CurrentNode, Distances1),
    D2 = array:get(CurrentNode, Distances2),

    if D1 /= -1 andalso D2 /= -1 ->
            CurrentMaxDist = max(D1, D2),
            if CurrentMaxDist < MinMaxDist ->
                    find_min_max_dist(CurrentNode + 1, N, Distances1, Distances2, CurrentMaxDist, CurrentNode);
               true ->
                    find_min_max_dist(CurrentNode + 1, N, Distances1, Distances2, MinMaxDist, ResultNode)
            end;
       true ->
            find_min_max_dist(CurrentNode + 1, N, Distances1, Distances2, MinMaxDist, ResultNode)
    end;
find_min_max_dist(_CurrentNode, _N, _Distances1, _Distances2, _MinMaxDist, ResultNode) ->
    ResultNode.