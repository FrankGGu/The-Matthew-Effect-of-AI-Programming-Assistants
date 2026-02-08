-module(solution).
-export([min_stone_sum/2]).

min_stone_sum(Piles, K) ->
    PilesList = lists:map(fun(X) -> -X end, Piles),
    SortedPiles = lists:sort(PilesList),
    min_stone_sum_helper(SortedPiles, K).

min_stone_sum_helper(Piles, 0) ->
    -lists:sum(Piles);
min_stone_sum_helper(Piles, K) ->
    Largest = hd(Piles),
    NewLargest = div(Largest, 2),
    NewPiles = [NewLargest | tl(Piles)],
    SortedNewPiles = lists:sort(NewPiles),
    min_stone_sum_helper(SortedNewPiles, K - 1).