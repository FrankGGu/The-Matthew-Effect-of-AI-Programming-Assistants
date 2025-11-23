-module(solution).
-export([reorderedPowerOf2/1]).

reorderedPowerOf2(N) ->
    Sorted = lists:sort(integer_to_list(N)),
    lists:any(fun(X) -> Sorted =:= lists:sort(integer_to_list(1 bsl X)) end, lists:seq(0, 30)).