-spec closest_meeting_node(Edges :: [integer()], Node1 :: integer(), Node2 :: integer()) -> integer().
closest_meeting_node(Edges, Node1, Node2) ->
    N = length(Edges),
    Dist1 = maps:from_list([{I, -1} || I <- lists:seq(0, N-1)]),
    Dist2 = maps:from_list([{I, -1} || I <- lists:seq(0, N-1)]),
    Dist1Updated = dfs(Edges, Node1, 0, Dist1),
    Dist2Updated = dfs(Edges, Node2, 0, Dist2),
    MinDist = infinity,
    Result = -1,
    find_min_node(N-1, Dist1Updated, Dist2Updated, MinDist, Result).

dfs(Edges, Node, CurrentDist, DistMap) ->
    case maps:get(Node, DistMap, -1) of
        -1 ->
            NewDistMap = maps:put(Node, CurrentDist, DistMap),
            NextNode = lists:nth(Node + 1, Edges),
            if
                NextNode =/= -1 -> dfs(Edges, NextNode, CurrentDist + 1, NewDistMap);
                true -> NewDistMap
            end;
        _ ->
            DistMap
    end.

find_min_node(-1, _, _, MinDist, Result) ->
    Result;
find_min_node(Node, Dist1, Dist2, MinDist, Result) ->
    D1 = maps:get(Node, Dist1),
    D2 = maps:get(Node, Dist2),
    if
        D1 =/= -1 andalso D2 =/= -1 ->
            CurrentMax = max(D1, D2),
            if
                CurrentMax < MinDist ->
                    find_min_node(Node - 1, Dist1, Dist2, CurrentMax, Node);
                CurrentMax =:= MinDist ->
                    if
                        Node < Result ->
                            find_min_node(Node - 1, Dist1, Dist2, MinDist, Node);
                        true ->
                            find_min_node(Node - 1, Dist1, Dist2, MinDist, Result)
                    end;
                true ->
                    find_min_node(Node - 1, Dist1, Dist2, MinDist, Result)
            end;
        true ->
            find_min_node(Node - 1, Dist1, Dist2, MinDist, Result)
    end.