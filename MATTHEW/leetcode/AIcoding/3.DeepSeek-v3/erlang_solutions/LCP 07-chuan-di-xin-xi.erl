-module(solution).
-export([num_ways/3]).

num_ways(N, Relation, K) ->
    Graph = build_graph(N, Relation),
    dfs(0, N - 1, K, Graph, 0).

build_graph(N, Relation) ->
    Graph = lists:duplicate(N, []),
    lists:foldl(fun([From, To], Acc) ->
                    update_graph(From, To, Acc)
                end, Graph, Relation).

update_graph(From, To, Graph) ->
    List = lists:nth(From + 1, Graph),
    NewList = [To | List],
    setelement(From + 1, Graph, NewList).

dfs(Current, Target, StepsLeft, Graph, Count) ->
    if
        StepsLeft =:= 0 ->
            if
                Current =:= Target -> Count + 1;
                true -> Count
            end;
        true ->
            Neighbors = lists:nth(Current + 1, Graph),
            lists:foldl(fun(Neighbor, Acc) ->
                            dfs(Neighbor, Target, StepsLeft - 1, Graph, Acc)
                        end, Count, Neighbors)
    end.