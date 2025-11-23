-module(solution).
-export([maximum_product/1]).

maximum_product(Numbers) ->
    Sorted = lists:sort(Numbers),
    Max1 = lists:last(Sorted),
    Max2 = lists:nth(length(Sorted)-1, Sorted),
    Max3 = lists:nth(length(Sorted)-2, Sorted),
    Min1 = lists:nth(1, Sorted),
    Min2 = lists:nth(2, Sorted),
    max(Max1 * Max2 * Max3, Max1 * Min1 * Min2).