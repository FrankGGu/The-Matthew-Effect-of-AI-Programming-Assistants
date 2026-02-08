-module(solution).
-export([find_kth_largest/2]).

find_kth_largest(nums, k) ->
    lists:nth(k, lists:sort(fun(X, Y) -> X > Y end, nums)).