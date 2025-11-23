-module(solution).
-export([max_product/1]).

max_product(List) ->
    Sorted = lists:sort(List),
    N = length(Sorted),
    (lists:nth(N, Sorted) - 1) * (lists:nth(N - 1, Sorted) - 1).