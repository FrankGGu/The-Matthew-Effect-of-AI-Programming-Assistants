-module(solution).
-export([build_matrix/3]).

build_matrix(K, RowConditions, ColConditions) ->
    RowOrder = topological_sort(K, RowConditions),
    ColOrder = topological_sort(K, ColConditions),
    case {RowOrder, ColOrder} of
        {false, _} -> [];
        {_, false} -> [];
        _ ->
            RowPos = maps:from_list([{Num, Pos} || {Pos, Num} <- lists:zip(lists:seq(1, K), RowOrder)]),
            ColPos = maps:from_list([{Num, Pos} || {Pos, Num} <- lists:zip(lists:seq(1, K), ColOrder)]),
            [[case maps:get(I, RowPos) =:= maps:get(J, ColPos) of
                true -> I;
                false -> 0
              end || J <- lists:seq(1, K)] || I <- lists:seq(1, K)]
    end.

topological_sort(K, Conditions) ->
    Graph = build_graph(K, Conditions),
    InDegree = compute_in_degree(K, Graph),
    Queue = [X || X <- lists:seq(1, K), maps:get(X, InDegree, 0) =:= 0],
    topological_sort(Queue, Graph, InDegree, []).

build_graph(K, Conditions) ->
    Graph = maps:from_list([{X, []} || X <- lists:seq(1, K)]),
    lists:foldl(fun([U, V], Acc) ->
                    maps:update_with(U, fun(Neighbors) -> [V | Neighbors] end, Acc)
                end, Graph, Conditions).

compute_in_degree(K, Graph) ->
    InDegree = maps:from_list([{X, 0} || X <- lists:seq(1, K)]),
    lists:foldl(fun(X, Acc) ->
                    lists:foldl(fun(Y, AccIn) ->
                                    maps:update_with(Y, fun(D) -> D + 1 end, AccIn)
                                end, Acc, maps:get(X, Graph))
                end, InDegree, maps:keys(Graph)).

topological_sort([], _, _, Result) when length(Result) =:= maps:size(build_graph(length(Result), [])) -> lists:reverse(Result);
topological_sort([], _, _, _) -> false;
topological_sort([X | Queue], Graph, InDegree, Result) ->
    NewInDegree = lists:foldl(fun(Y, Acc) ->
                                maps:update_with(Y, fun(D) -> D - 1 end, Acc)
                             end, InDegree, maps:get(X, Graph)),
    NewQueue = Queue ++ [Y || Y <- maps:get(X, Graph), maps:get(Y, NewInDegree) =:= 0],
    topological_sort(NewQueue, Graph, NewInDegree, [X | Result]).