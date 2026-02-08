-module(solution).
-export([num_ways/2]).

num_ways(N, K) ->
    Max = 1000000007,
    DP = array:new(N+1, {default, 0}),
    array:set(0, 1, DP),
    Ways = array:get(0, DP),
    lists:foldl(fun(I, Acc) ->
        array:set(I, (array:get(I-1, Acc) + array:get(I-K, Acc)) rem Max, Acc)
    end, DP, lists:seq(1, N)),

    array:get(N, DP).

array_get(Arr, Index) when Index < 0 -> 0;
array_get(Arr, Index) -> array:get(Index, Arr).