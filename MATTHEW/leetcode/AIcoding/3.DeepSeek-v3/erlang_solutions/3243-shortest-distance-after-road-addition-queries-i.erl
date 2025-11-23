-module(solution).
-export([shortest_distance_after_queries/2]).

shortest_distance_after_queries(N, Queries) ->
    Adj = maps:new(),
    Dist = lists:duplicate(N, lists:duplicate(N, -1)),
    {NewAdj, NewDist} = build_initial_graph(N, Adj, Dist),
    process_queries(Queries, NewAdj, NewDist, []).

build_initial_graph(1, Adj, Dist) ->
    {Adj, Dist};
build_initial_graph(N, Adj, Dist) ->
    U = N - 1,
    V = N - 2,
    NewAdj = add_edge(Adj, U, V),
    NewDist = update_dist(Dist, U, V, 1),
    build_initial_graph(N - 1, NewAdj, NewDist).

add_edge(Adj, U, V) ->
    case maps:is_key(U, Adj) of
        true ->
            Neighbors = maps:get(U, Adj),
            maps:put(U, [V | Neighbors], Adj);
        false ->
            maps:put(U, [V], Adj)
    end.

update_dist(Dist, U, V, D) ->
    Row = lists:nth(U + 1, Dist),
    NewRow = setnth(V + 1, Row, D),
    NewDist = setnth(U + 1, Dist, NewRow),
    Row2 = lists:nth(V + 1, NewDist),
    NewRow2 = setnth(U + 1, Row2, D),
    setnth(V + 1, NewDist, NewRow2).

setnth(1, [_ | Rest], New) -> [New | Rest];
setnth(N, [E | Rest], New) -> [E | setnth(N - 1, Rest, New)].

process_queries([], _Adj, Dist, Acc) ->
    lists:reverse(Acc);
process_queries([{U, V} | Rest], Adj, Dist, Acc) ->
    NewAdj = add_edge(Adj, U, V),
    NewAdj2 = add_edge(NewAdj, V, U),
    NewDist = update_dist(Dist, U, V, 1),
    AllPairs = floyd_warshall(NewAdj2, NewDist, length(NewDist)),
    Sum = lists:sum([lists:sum([D || D <- Row, D =/= -1]) || Row <- AllPairs]),
    process_queries(Rest, NewAdj2, AllPairs, [Sum div 2 | Acc]).

floyd_warshall(Adj, Dist, N) ->
    Initial = Dist,
    floyd_warshall_iter(0, N, Adj, Initial).

floyd_warshall_iter(K, N, _Adj, Dist) when K == N ->
    Dist;
floyd_warshall_iter(K, N, Adj, Dist) ->
    NewDist = lists:map(fun(I) ->
        lists:map(fun(J) ->
            case I == J of
                true -> 0;
                false ->
                    D1 = lists:nth(I + 1, lists:nth(K + 1, Dist)),
                    D2 = lists:nth(K + 1, lists:nth(J + 1, Dist)),
                    Current = lists:nth(I + 1, lists:nth(J + 1, Dist)),
                    if
                        D1 =/= -1 andalso D2 =/= -1 ->
                            case Current of
                                -1 -> D1 + D2;
                                _ -> min(Current, D1 + D2)
                            end;
                        true -> Current
                    end
            end
        end, lists:seq(0, N - 1))
    end, lists:seq(0, N - 1)),
    floyd_warshall_iter(K + 1, N, Adj, NewDist).