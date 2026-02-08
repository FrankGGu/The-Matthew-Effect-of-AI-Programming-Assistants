-module(solution).
-export([distanceK/3]).

distanceK(Root, Target, K) ->
    AdjList = build_adj_list(Root, maps:new()),
    bfs(Target#tree_node.val, K, AdjList).

build_adj_list(null, AdjList) ->
    AdjList;
build_adj_list(Node, AdjList) ->
    Val = Node#tree_node.val,
    Left = Node#tree_node.left,
    Right = Node#tree_node.right,

    CurrentAdjList = maps:update_with(Val, fun(L) -> L end, [], AdjList),

    AdjListWithLeft =
        case Left of
            null -> CurrentAdjList;
            _ ->
                LeftVal = Left#tree_node.val,
                maps:update_with(Val, fun(L) -> [LeftVal | L] end, [],
                    maps:update_with(LeftVal, fun(L) -> [Val | L] end, [], CurrentAdjList))
        end,

    AdjListWithRight =
        case Right of
            null -> AdjListWithLeft;
            _ ->
                RightVal = Right#tree_node.val,
                maps:update_with(Val, fun(L) -> [RightVal | L] end, [],
                    maps:update_with(RightVal, fun(L) -> [Val | L] end, [], AdjListWithLeft))
        end,

    AdjListAfterLeftRec =
        case Left of
            null -> AdjListWithRight;
            _ -> build_adj_list(Left, AdjListWithRight)
        end,

    case Right of
        null -> AdjListAfterLeftRec;
        _ -> build_adj_list(Right, AdjListAfterLeftRec)
    end.

bfs(TargetVal, K, AdjList) ->
    Q = queue:in({TargetVal, 0}, queue:new()),
    Visited = sets:add_element(TargetVal, sets:new()),
    bfs_loop(Q, Visited, K, AdjList, []).

bfs_loop(Q, _Visited, K, _AdjList, Acc) when queue:is_empty(Q) ->
    Acc;
bfs_loop(Q, Visited, K, AdjList, Acc) ->
    {{value, {CurrentVal, Dist}}, Q1} = queue:out(Q),

    if Dist == K ->
        bfs_loop(Q1, Visited, K, AdjList, [CurrentVal | Acc]);
    Dist > K ->
        bfs_loop(Q1, Visited, K, AdjList, Acc);
    true ->
        Neighbors = maps:get(CurrentVal, AdjList, []),
        {NewQ, NewVisited} = lists:foldl(
            fun(Neighbor, {AccQ, AccVisited}) ->
                if sets:is_element(Neighbor, AccVisited) ->
                    {AccQ, AccVisited};
                true ->
                    {queue:in({Neighbor, Dist + 1}, AccQ), sets:add_element(Neighbor, AccVisited)}
                end
            end,
            {Q1, Visited},
            Neighbors
        ),
        bfs_loop(NewQ, NewVisited, K, AdjList, Acc)
    end.