-module(maximum_multiplication_score).
-export([maximum_multiplication_score/2]).

maximum_multiplication_score(A, B) ->
    SortedA = lists:sort(A),
    SortedB = lists:sort(B),
    Len = length(SortedA),
    lists:foldl(fun(X, Acc) -> Acc * X end, 1, lists:sublist(SortedA, Len)).