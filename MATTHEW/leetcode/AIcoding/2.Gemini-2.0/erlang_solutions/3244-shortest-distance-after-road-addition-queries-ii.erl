-module(shortest_distance_after_road_addition_queries_ii).
-export([solve/2]).

solve(N, Edges, Queries) ->
    solve_helper(N, Edges, Queries, []).

solve_helper(_, [], _, Acc) ->
    lists:reverse(Acc);
solve_helper(N, Edges, [Query|Queries], Acc) ->
    {U, V, W} = Query,
    NewEdges = Edges ++ [{U, V, W}],
    Distances = floyd_warshall(N, NewEdges),
    ShortestDistance = Distances ! {0, 0},
    solve_helper(N, NewEdges, Queries, [ShortestDistance|Acc]).

floyd_warshall(N, Edges) ->
    Distances = create_distance_matrix(N, Edges),
    FloydWarshall = fun(K, Dist) ->
                        fun(I, Dist2) ->
                            fun(J) ->
                                case Dist ! {I,K} + Dist ! {K,J} < Dist ! {I,J} of
                                    true ->
                                        Dist2 ! {I,J, Dist ! {I,K} + Dist ! {K,J)};
                                    false ->
                                        Dist2 ! {I,J, Dist ! {I,J}}
                                end
                            end
                        end
                    end,

    NewDistances0 = lists:foldl(
        fun(K, AccDist) ->
            NewDistances1 = lists:foldl(
                fun(I, AccDist2) ->
                    NewDistances3 = lists:foldl(
                        fun(J, AccDist3) ->
                            AccDist3 ! {I,J, min(AccDist ! {I,J}, AccDist ! {I,K} + AccDist ! {K,J})}
                        end,
                        AccDist2,
                        lists:seq(1, N)
                    ),
                    NewDistances3
                end,
                AccDist,
                lists:seq(1, N)
            ),
            NewDistances1
        end,
        Distances,
        lists:seq(1, N)
    ),
    NewDistances0.

create_distance_matrix(N, Edges) ->
    Distances = dict:new(),
    Inf = 1 bsl 60, 

    Dist = lists:foldl(fun({U, V, W}, Acc) -> dict:store({U, V}, W, Acc) end, dict:new(), Edges),

    InitDist = fun(I, J, Acc) ->
        case dict:find({I, J}, Dist) of
            {ok, W} ->
                dict:store({I, J}, W, Acc);
            error ->
                if I == J then
                    dict:store({I, J}, 0, Acc)
                else
                    dict:store({I, J}, Inf, Acc)
                end
        end
    end,

    NewDistances = lists:foldl(
        fun(I, Acc) ->
            NewDistances2 = lists:foldl(
                fun(J, Acc2) ->
                    InitDist(I, J, Acc2)
                end,
                Acc,
                lists:seq(1, N)
            ),
            NewDistances2
        end,
        Distances,
        lists:seq(1, N)
    ),

    NewDistances.