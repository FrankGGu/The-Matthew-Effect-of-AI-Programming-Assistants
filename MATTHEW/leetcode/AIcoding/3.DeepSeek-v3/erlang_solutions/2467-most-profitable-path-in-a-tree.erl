-module(solution).
-export([most_profitable_path/2]).

most_profitable_path(Edges, Bob, Amount) ->
    N = length(Amount),
    Adj = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(U, fun(L) -> [V | L] end, [V], Acc)
                      end, #{}, Edges),
    Adj1 = lists:foldl(fun([U, V], Acc) ->
                          maps:update_with(V, fun(L) -> [U | L] end, [U], Acc)
                      end, Adj, Edges),
    Parent = array:new(N, {default, -1}),
    Depth = array:new(N, {default, 0}),
    {Parent1, Depth1} = dfs(0, -1, 0, Adj1, Parent, Depth),
    Path = get_path(Bob, Parent1),
    Time = maps:from_list([{Node, T} || {T, Node} <- lists:zip(lists:seq(0, length(Path) - 1), Path)]),
    {Visited, _} = bfs(0, -1, 0, 0, Adj1, Time, Amount, sets:new(), -1000000000),
    Visited.

dfs(Node, P, D, Adj, Parent, Depth) ->
    Parent1 = array:set(Node, P, Parent),
    Depth1 = array:set(Node, D, Depth),
    Neighbors = maps:get(Node, Adj, []),
    lists:foldl(fun(Neighbor, {ParentAcc, DepthAcc}) ->
                    case Neighbor =/= P of
                        true -> dfs(Neighbor, Node, D + 1, Adj, ParentAcc, DepthAcc);
                        false -> {ParentAcc, DepthAcc}
                    end
                end, {Parent1, Depth1}, Neighbors).

get_path(Node, Parent) ->
    get_path(Node, Parent, []).

get_path(Node, Parent, Acc) when Node =:= -1 ->
    Acc;
get_path(Node, Parent, Acc) ->
    get_path(array:get(Node, Parent), Parent, [Node | Acc]).

bfs(Node, P, T, Profit, Adj, Time, Amount, Visited, MaxProfit) ->
    case sets:is_element(Node, Visited) of
        true -> {MaxProfit, Visited};
        false ->
            Visited1 = sets:add_element(Node, Visited),
            Profit1 = case maps:get(Node, Time, -1) of
                         -1 -> Profit + array:get(Node, Amount);
                         T1 when T < T1 -> Profit + array:get(Node, Amount);
                         T1 when T =:= T1 -> Profit + array:get(Node, Amount) div 2;
                         _ -> Profit
                      end,
            IsLeaf = case maps:get(Node, Adj, []) -- [P] of
                         [] -> true;
                         _ -> false
                     end,
            MaxProfit1 = case IsLeaf of
                            true -> max(MaxProfit, Profit1);
                            false -> MaxProfit
                        end,
            Neighbors = maps:get(Node, Adj, []),
            lists:foldl(fun(Neighbor, {MP, V}) ->
                            case Neighbor =/= P of
                                true -> bfs(Neighbor, Node, T + 1, Profit1, Adj, Time, Amount, V, MP);
                                false -> {MP, V}
                            end
                        end, {MaxProfit1, Visited1}, Neighbors)
    end.