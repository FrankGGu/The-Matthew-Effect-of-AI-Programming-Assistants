-module(collect_coins_in_tree).
-export([collect_the_coins/2]).

collect_the_coins(Coins, Edges) ->
    N = length(Coins),
    Adj = lists:foldl(fun([U, V], Acc) ->
        maps:update_with(U, fun(L) -> [V | L] end, [V], 
        maps:update_with(V, fun(L) -> [U | L] end, [U], Acc))
    end, #{}, Edges),
    Leaves = [Node || Node <- lists:seq(0, N-1), maps:get(Node, Adj, []) == [1]],
    Q = lists:filter(fun(Node) -> lists:nth(Node+1, Coins) == 0 end, Leaves),
    Trimmed = trim_leaves(Q, Adj),
    case maps:size(Trimmed) of
        0 -> 0;
        _ ->
            Diameter = find_diameter(Trimmed),
            max(0, 2 * (maps:size(Trimmed) - 1) - Diameter)
    end.

trim_leaves(Q, Adj) ->
    case Q of
        [] -> Adj;
        _ ->
            NewAdj = lists:foldl(fun(Node, Acc) ->
                case maps:get(Node, Acc, []) of
                    [Neighbor] ->
                        NewAcc = maps:update_with(Neighbor, fun(L) -> lists:delete(Node, L) end, [], Acc),
                        maps:remove(Node, NewAcc);
                    _ -> Acc
                end
            end, Adj, Q),
            NewQ = lists:foldl(fun(Node, Acc) ->
                case maps:get(Node, NewAdj, []) of
                    [Neighbor] when length(maps:get(Neighbor, NewAdj, [])) == 1 -> [Neighbor | Acc];
                    _ -> Acc
                end
            end, [], maps:keys(NewAdj)),
            trim_leaves(NewQ, NewAdj)
    end.

find_diameter(Adj) ->
    case maps:size(Adj) of
        0 -> 0;
        _ ->
            Start = hd(maps:keys(Adj)),
            {Farthest, _} = bfs(Start, Adj),
            {Farthest2, Distance} = bfs(Farthest, Adj),
            Distance
    end.

bfs(Start, Adj) ->
    Visited = sets:from_list([Start]),
    Q = [{Start, 0}],
    bfs_helper(Q, Visited, Adj, Start, 0).

bfs_helper([], _, _, Farthest, MaxDist) -> {Farthest, MaxDist};
bfs_helper([{Node, Dist} | Rest], Visited, Adj, _, MaxDist) ->
    NewVisited = sets:add_element(Node, Visited),
    Neighbors = maps:get(Node, Adj, []),
    {NewQ, NewFarthest, NewMaxDist} = lists:foldl(fun(Neighbor, {QAcc, FAcc, DAcc}) ->
        case sets:is_element(Neighbor, NewVisited) of
            false ->
                NewQAcc = [{Neighbor, Dist + 1} | QAcc],
                NewDAcc = max(DAcc, Dist + 1),
                NewFAcc = if Dist + 1 > DAcc -> Neighbor; true -> FAcc end,
                {NewQAcc, NewFAcc, NewDAcc};
            true -> {QAcc, FAcc, DAcc}
        end
    end, {Rest, Node, MaxDist}, Neighbors),
    bfs_helper(NewQ, NewVisited, Adj, NewFarthest, NewMaxDist).