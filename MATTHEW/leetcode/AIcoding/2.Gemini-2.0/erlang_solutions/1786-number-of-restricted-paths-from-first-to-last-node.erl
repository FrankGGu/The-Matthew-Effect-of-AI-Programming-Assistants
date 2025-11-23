-module(restricted_paths).
-export([count_restricted_paths/2]).

count_restricted_paths(N, Edges) ->
    Graph = build_graph(Edges, N),
    Distances = dijkstra(Graph, N),
    memo(N, Graph, Distances).

build_graph(Edges, N) ->
    lists:foldl(
        fun([[U, V, Weight]], Acc) ->
            Acc#{U => lists:keystore(V, 1, lists:keyfind(U, 1, maps:get(U, Acc, [])), {V, Weight}),
                  V => lists:keystore(U, 1, lists:keyfind(V, 1, maps:get(V, Acc, [])), {U, Weight})};
           ([], Acc) ->
            Acc
        end,
        maps:from_list([{I, []} || I <- lists:seq(1, N)]),
        Edges).

dijkstra(Graph, N) ->
    Q = gb_sets:from_list([{0, N}]),
    Distances = maps:from_list([{I, infinity} || I <- lists:seq(1, N)])#{N => 0},
    dijkstra_helper(Graph, Q, Distances, N).

dijkstra_helper(_Graph, Q, Distances, _N) when gb_sets:is_empty(Q) ->
    Distances;
dijkstra_helper(Graph, Q, Distances, N) ->
    {{D, U}, Q1} = gb_sets:take_smallest(Q),
    Neighbors = maps:get(U, Graph, []),
    {Q2, Distances1} = lists:foldl(
        fun({V, Weight}, {AccQ, AccDist}) ->
            if AccDist[V] > D + Weight then
                Q3 = gb_sets:add({D + Weight, V}, AccQ),
                {Q3, AccDist#{V => D + Weight}}
            else
                {AccQ, AccDist}
            end
        end,
        {Q, Distances},
        Neighbors),
    dijkstra_helper(Graph, Q2, Distances1, N).

memo(N, Graph, Distances) ->
    memo_helper(1, N, Graph, Distances, maps:new()).

memo_helper(U, N, Graph, Distances, Memo) ->
    case maps:get(U, Memo, undefined) of
        undefined ->
            case U of
                N ->
                    maps:put(U, 1, Memo);
                _ ->
                    Neighbors = maps:get(U, Graph, []),
                    Paths = lists:foldl(
                        fun({V, _}, Acc) ->
                            if Distances[V] < Distances[U] then
                                Acc + memo_helper(V, N, Graph, Distances, Memo)
                            else
                                Acc
                            end
                        end,
                        0,
                        Neighbors),
                    Result = Paths rem 1000000007,
                    maps:put(U, Result, Memo)
            end,
            maps:get(U, maps:put(U, maps:get(U, Memo, 0) rem 1000000007, Memo), Memo);
        Value ->
            Value
    end.

infinity() -> 1 bsl 60.