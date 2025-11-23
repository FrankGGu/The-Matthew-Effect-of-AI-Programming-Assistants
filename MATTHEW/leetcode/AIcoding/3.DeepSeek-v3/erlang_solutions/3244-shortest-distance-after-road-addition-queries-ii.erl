-module(solution).
-export([shortest_distance/3]).

shortest_distance(N, Roads, Queries) ->
    Adj = build_adj(N, Roads),
    Dist = floyd_warshall(N, Adj),
    process_queries(Queries, Dist, []).

build_adj(N, Roads) ->
    Adj = lists:duplicate(N, lists:duplicate(N, infinity)),
    lists:foldl(fun([U, V, W], Acc) ->
                    set(U, V, W, set(V, U, W, Acc))
                end, Adj, Roads).

set(I, J, Val, Matrix) ->
    Row = lists:nth(I, Matrix),
    NewRow = setelement(J, list_to_tuple(Row), Val),
    setelement(I, list_to_tuple(Matrix), tuple_to_list(NewRow)).

floyd_warshall(N, Adj) ->
    Dist = list_to_tuple([list_to_tuple(Row) || Row <- Adj]),
    floyd_warshall(N, Dist, 1).

floyd_warshall(N, Dist, K) when K > N ->
    Dist;
floyd_warshall(N, Dist, K) ->
    NewDist = lists:foldl(fun(I, Acc) ->
                              lists:foldl(fun(J, Acc2) ->
                                              case element(K, element(I, Acc2)) + element(K, element(J, Acc2)) < element(J, element(I, Acc2)) of
                                                  true ->
                                                      set(I, J, element(K, element(I, Acc2)) + element(K, element(J, Acc2)), Acc2);
                                                  false ->
                                                      Acc2
                                              end
                                          end, Acc, lists:seq(1, N))
                          end, Dist, lists:seq(1, N)),
    floyd_warshall(N, NewDist, K + 1).

process_queries([], _Dist, Acc) ->
    lists:reverse(Acc);
process_queries([[U, V] | Rest], Dist, Acc) ->
    D = element(V, element(U, Dist)),
    case D of
        infinity -> process_queries(Rest, Dist, [-1 | Acc]);
        _ -> process_queries(Rest, Dist, [D | Acc])
    end.