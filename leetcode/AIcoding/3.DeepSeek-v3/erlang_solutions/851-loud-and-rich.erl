-spec loud_and_rich(Richer :: [[integer()]], Quiet :: [integer()]) -> [integer()].
loud_and_rich(Richer, Quiet) ->
    N = length(Quiet),
    Graph = build_graph(Richer, N),
    Ans = lists:duplicate(N, -1),
    lists:map(fun(X) -> dfs(X, Graph, Quiet, Ans) end, lists:seq(0, N-1)).

build_graph(Richer, N) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun([A, B], Acc) ->
                    update_graph(A, B, Acc)
                end, Graph, Richer).

update_graph(A, B, Graph) ->
    List = lists:nth(B+1, Graph),
    NewList = [A | List],
    set_nth(B+1, NewList, Graph).

set_nth(1, Val, [_ | Rest]) -> [Val | Rest];
set_nth(N, Val, [H | Rest]) -> [H | set_nth(N-1, Val, Rest)].

dfs(X, Graph, Quiet, Ans) ->
    case lists:nth(X+1, Ans) of
        -1 ->
            Min = X,
            Neighbors = lists:nth(X+1, Graph),
            NewMin = lists:foldl(fun(Neighbor, Acc) ->
                                    Y = dfs(Neighbor, Graph, Quiet, Ans),
                                    case lists:nth(Y+1, Quiet) < lists:nth(Acc+1, Quiet) of
                                        true -> Y;
                                        false -> Acc
                                    end
                                 end, Min, Neighbors),
            set_nth(X+1, NewMin, Ans),
            NewMin;
        Val -> Val
    end.