-module(solution).
-export([check_tree/2]).

check_tree(N, A) ->
    case lists:map(fun({X, Y}) -> {X, Y} end, A) of
        Edges when length(Edges) =:= N - 1 ->
            if 
                is_tree(Edges, N) -> 1;
                true -> 0 
            end;
        _ -> 0
    end.

is_tree(Edges, N) ->
    Graph = build_graph(Edges),
    case lists:map(fun({_, V}) -> V end, maps:to_list(Graph)) of
        L when length(L) =:= N -> true;
        _ -> false
    end.

build_graph(Edges) ->
    lists:foldl(fun({X, Y}, Acc) ->
        Acc1 = maps:update_with(X, fun(V) -> [Y | V] end, [Y], Acc),
        maps:update_with(Y, fun(V) -> [X | V] end, [X], Acc1)
    end, maps:new(), Edges).