-module(solution).
-export([kth_max/2]).

kth_max(List, K) ->
    Sorted = lists:sort(fun(A, B) -> A > B end, List),
    lists:nth(K, Sorted).