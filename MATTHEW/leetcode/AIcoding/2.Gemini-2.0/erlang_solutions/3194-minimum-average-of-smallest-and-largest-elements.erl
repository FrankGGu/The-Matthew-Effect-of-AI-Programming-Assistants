-module(minimum_average_smallest_largest).
-export([solve/1]).

solve(Nums) ->
    N = length(Nums),
    MinAvg = lists:foldl(fun(I, Acc) ->
                                  SubArray = lists:sublist(Nums, I, 2),
                                  [Min, Max] = lists:sort(SubArray),
                                  Avg = (Min + Max) / 2.0,
                                  min(Acc, Avg)
                          end, infinity, lists:seq(1, N - 1)).