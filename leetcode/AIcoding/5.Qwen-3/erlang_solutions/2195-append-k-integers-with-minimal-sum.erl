-module(solution).
-export([min_sum/2]).

min_sum(Nums, K) ->
    lists:foldl(fun(_, Acc) -> Acc + lists:sum(lists:sort(Nums)) end, 0, lists:seq(1, K)).