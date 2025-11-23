-module(solution).
-export([frog_position/4]).

frog_position(N, Edges, T, Target) ->
    Adj = build_adjacency_list(N, Edges),
    case Target == 1 of
        true ->
            case length(Adj[1]) == 0 of
                true -> 1.0;
                false -> 0.0
            end;
        false ->
            dfs(1, 0, T, Target, 1.0, Adj)
    end.

build_adjacency_list(N, Edges) ->
    Adj = lists:foldl(fun(I, Acc) -> maps:put(I, [], Acc) end, #{}, lists:seq(1, N)),
    lists:foldl(fun([U, V], Acc) ->
                    Acc1 = maps:update_with(U, fun(L) -> [V | L] end, Acc),
                    maps:update_with(V, fun(L) -> [U | L] end, Acc1)
                end, Adj, Edges).

dfs(Node, Parent, TimeLeft, Target, Prob, Adj) ->
    if
        TimeLeft == 0 ->
            if
                Node == Target -> Prob;
                true -> 0.0
            end;
        true ->
            Children = lists:filter(fun(C) -> C /= Parent end, maps:get(Node, Adj)),
            case Children of
                [] ->
                    if
                        Node == Target -> Prob;
                        true -> 0.0
                    end;
                _ ->
                    ChildProb = Prob / length(Children),
                    lists:foldl(fun(Child, Acc) ->
                                    case Acc of
                                        0.0 -> dfs(Child, Node, TimeLeft - 1, Target, ChildProb, Adj);
                                        _ -> Acc
                                    end
                                end, 0.0, Children)
            end
    end.