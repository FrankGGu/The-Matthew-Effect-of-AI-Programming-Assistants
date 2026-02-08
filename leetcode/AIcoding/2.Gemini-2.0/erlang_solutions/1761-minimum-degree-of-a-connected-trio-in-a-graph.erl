-module(minimum_degree_trio).
-export([min_trio_degree/1]).

min_trio_degree(N, Edges) ->
    Adj = create_adjacency_matrix(N, Edges),
    min_trio_degree_helper(N, Adj).

create_adjacency_matrix(N, Edges) ->
    lists:foldl(
        fun({U, V}, Acc) ->
            set_edge(U, V, Acc)
        end,
        create_empty_adjacency_matrix(N),
        Edges
    ).

create_empty_adjacency_matrix(N) ->
    lists:duplicate(N, lists:duplicate(N, 0)).

set_edge(U, V, Adj) ->
    Adj1 = lists:update(U - 1, lists:update(V - 1, 1, lists:nth(U - 1, Adj)), Adj),
    lists:update(V - 1, lists:update(U - 1, 1, lists:nth(V - 1, Adj1)), Adj1).

min_trio_degree_helper(N, Adj) ->
    MinDegree = lists:foldl(
        fun(I, Acc) ->
            lists:foldl(
                fun(J, Acc2) ->
                    lists:foldl(
                        fun(K, Acc3) ->
                            if
                                I < J, J < K, lists:nth(J - 1, lists:nth(I - 1, Adj)) == 1, lists:nth(K - 1, lists:nth(I - 1, Adj)) == 1, lists:nth(K - 1, lists:nth(J - 1, Adj)) == 1 ->
                                    DegreeI = degree(I, Adj),
                                    DegreeJ = degree(J, Adj),
                                    DegreeK = degree(K, Adj),
                                    min(Acc3, DegreeI + DegreeJ + DegreeK - 6);
                                true ->
                                    Acc3
                            end
                        end,
                        Acc2,
                        lists:seq(1, N)
                    )
                end,
                Acc,
                lists:seq(1, N)
            )
        end,
        infinity,
        lists:seq(1, N)
    ),
    if MinDegree == infinity ->
        -1;
    true ->
        MinDegree
    end.

degree(Node, Adj) ->
    lists:sum(lists:nth(Node - 1, Adj)).

infinity() ->
    16#7fffffff#.

min_trio_degree(Edges) ->
    N = lists:foldl(fun({U, V}, Acc) -> max(Acc, max(U,V)), 0, Edges),
    min_trio_degree(N, Edges).