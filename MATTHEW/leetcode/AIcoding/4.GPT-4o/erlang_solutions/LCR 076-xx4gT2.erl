-module(solution).
-export([find_kth_largest/2]).

find_kth_largest(Numbers, K) ->
    Sorted = lists:sort(fun(X, Y) -> X > Y end, Numbers),
    lists:nth(K, Sorted).