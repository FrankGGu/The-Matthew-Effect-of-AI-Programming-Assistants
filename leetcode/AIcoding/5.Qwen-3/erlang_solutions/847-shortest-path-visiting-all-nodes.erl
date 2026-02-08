-module(shortest_path_visiting_all_nodes).
-export([search/1]).

search(Graph) ->
    N = length(Graph),
    AllVisited = (1 bsl N) - 1,
    Q = queue:new(),
    Visited = dict:new(),
    InitialStates = lists:seq(0, N-1),
    Q1 = lists:foldl(fun(I, Acc) -> queue:in({I, 1 bsl I, 0}, Acc) end, Q, InitialStates),
    Visited1 = lists:foldl(fun(I, Acc) -> dict:store({I, 1 bsl I}, true, Acc) end, Visited, InitialStates),
    bfs(Q1, Visited1, Graph, AllVisited, N).

bfs(Q, Visited, Graph, AllVisited, N) ->
    case queue:out(Q) of
        {empty, _} -> -1;
        {{value, {Node, Mask, Dist}}, Q2} ->
            if
                Mask == AllVisited -> Dist;
                true ->
                    Neighbors = lists:nth(Node + 1, Graph),
                    NewQ = lists:foldl(fun(NextNode, Acc) ->
                        NewMask = Mask bor (1 bsl NextNode),
                        Key = {NextNode, NewMask},
                        case dict:is_key(Key, Visited) of
                            true -> Acc;
                            false ->
                                Visited1 = dict:store(Key, true, Visited),
                                queue:in({NextNode, NewMask, Dist + 1}, Acc)
                        end
                    end, Q2, Neighbors),
                    bfs(NewQ, Visited, Graph, AllVisited, N)
            end
    end.