-module(solution).
-export([maxValueOfCoins/2]).

maxValueOfCoins(Piles, K) ->
    N = length(Piles),
    maxValue(Piles, K, N).

maxValue(_, 0, _) -> 0;
maxValue([], _, _) -> 0;
maxValue(Piles, K, N) ->
    lists:max(
        [lists:sum(lists:sublist(Pile, min(K, length(Pile)))) + maxValue(tl(Piles), K - min(K, length(Pile)), N - 1) || Pile <- Piles]
    ).