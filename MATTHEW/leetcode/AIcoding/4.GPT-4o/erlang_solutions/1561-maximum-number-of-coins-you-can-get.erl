-module(solution).
-export([maxCoins/1]).

maxCoins(Piles) ->
    SortedPiles = lists:sort(Piles),
    N = length(SortedPiles) div 3,
    lists:sum(lists:sublist(SortedPiles, N * 2 + 1, N)).