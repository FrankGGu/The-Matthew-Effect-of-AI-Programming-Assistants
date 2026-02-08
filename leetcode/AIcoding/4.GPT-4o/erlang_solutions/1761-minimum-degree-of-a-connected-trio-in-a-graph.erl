-module(solution).
-export([min_trio_degree/2]).

min_trio_degree(N, Edges) ->
    Graph = build_graph(N, Edges),
    find_min_degree(Graph, N).

build_graph(N, Edges) ->
    Lists = lists:duplicate(N + 1, []),
    lists:foldl(fun({A, B}, Acc) ->
        lists:update_counter(A, B, Acc),
        lists:update_counter(B, A, Acc)
    end, Lists, Edges).

lists:update_counter(Key, Value, Acc) ->
    lists:replace(Key, [Value | lists:nth(Key, Acc)], Acc).

find_min_degree(Graph, N) ->
    MinDegree = lists:foldl(fun(X, Acc) -> min(Acc, degree_of_trio(Graph, X)) end, infinity, lists:seq(1, N)),
    if MinDegree == infinity -> -1; true -> MinDegree end.

degree_of_trio(Graph, X) ->
    Neighbors = lists:nth(X, Graph),
    TrioDegrees = lists:map(fun(Y) -> length(lists:intersect(Neighbors, lists:nth(Y, Graph))) end, Neighbors),
    lists:sum(TrioDegrees).