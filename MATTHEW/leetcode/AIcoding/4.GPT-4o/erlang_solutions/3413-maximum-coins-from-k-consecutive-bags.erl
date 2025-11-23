-module(solution).
-export([maxCoins/2]).

maxCoins(Bags, K) ->
    SortedBags = lists:sort(fun(A, B) -> A > B end, Bags),
    lists:sum(lists:sublist(SortedBags, K)).