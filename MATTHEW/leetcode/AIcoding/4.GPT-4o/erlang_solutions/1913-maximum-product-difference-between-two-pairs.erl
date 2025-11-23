-module(solution).
-export([max_product_difference/1]).

max_product_difference(Numbers) ->
    Sorted = lists:sort(Numbers),
    Max1 = lists:last(Sorted),
    Max2 = lists:nth(length(Sorted) - 1, Sorted),
    Min1 = hd(Sorted),
    Min2 = lists:nth(2, Sorted),
    (Max1 * Max2) - (Min1 * Min2).