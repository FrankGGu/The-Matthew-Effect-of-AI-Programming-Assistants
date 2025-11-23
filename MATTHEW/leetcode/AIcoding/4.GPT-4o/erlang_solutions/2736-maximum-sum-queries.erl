-module(solution).
-export([max_sum_queries/3]).

max_sum_queries(N, A, Queries) ->
    SortedA = lists:sort(A),
    lists:map(fun({X, Id}) -> {X, sum_largest_elements(X, SortedA)} end, lists:zip(Queries, lists:seq(1, length(Queries)))).

sum_largest_elements(X, SortedA) ->
    Count = lists:sum(lists:map(fun(Y) -> if Y > X -> 1; true -> 0 end end, SortedA)),
    lists:sum(lists:reverse(lists:sublist(SortedA, Count))).