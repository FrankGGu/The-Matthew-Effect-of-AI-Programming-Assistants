-module(solution).
-export([min_pair_sum/1]).

min_pair_sum(Numbers) ->
    Sorted = lists:sort(Numbers),
    PairSums = lists:map(fun({X, Y}) -> X + Y end, lists:zip(Sorted, lists:reverse(Sorted))),
    lists:max(PairSums).