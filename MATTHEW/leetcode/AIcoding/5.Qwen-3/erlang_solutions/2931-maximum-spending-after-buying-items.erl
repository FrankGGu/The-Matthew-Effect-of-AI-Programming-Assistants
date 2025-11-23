-module(max_spending).
-export([maxSpending/1]).

maxSpending(Prices) ->
    Sorted = lists:sort(fun(A, B) -> A < B end, Prices),
    lists:foldl(fun(X, Acc) -> Acc + X end, 0, Sorted).