-module(solution).
-export([kthSmallest/3]).

kthSmallest(N, K, instructions) ->
    lists:sort(instructions),
    kth_smallest(N, K, instructions).

kth_smallest(_, 0, []) -> undefined;
kth_smallest(N, K, Instructions) ->
    {ok, Sorted} = lists:sort(Instructions),
    lists:nth(K, Sorted).