-module(solution).
-export([maxSumKElements/2]).

maxSumKElements(List, K) ->
    Sorted = lists:sort(>=(fun(X, Y) -> X > Y end), List),
    Sum = lists:sum(lists:sublist(Sorted, K)),
    Sum.