-module(maximum_coins).
-export([max_coins/1]).

max_coins(Piles) ->
    SortedPiles = lists:sort(Piles),
    N = length(SortedPiles),
    max_coins_helper(SortedPiles, N div 3, 0).

max_coins_helper(_Piles, 0, Acc) ->
    Acc;
max_coins_helper(Piles, Count, Acc) ->
    N = length(Piles),
    Acc1 = Acc + lists:nth(N - 1, Piles),
    max_coins_helper(lists:sublist(Piles, 1, N - 2), Count - 1, Acc1).