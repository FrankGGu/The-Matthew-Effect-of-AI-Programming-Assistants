-module(solution).
-export([repeated_n_times/1]).

repeated_n_times(List) ->
    CountMap = lists:foldl(fun(X, Acc) ->
        maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc)
    end, maps:empty(), List),
    maps:fold(fun(_, Count, Acc) -> if Count == 2 -> Acc; true -> Acc end end, undefined, CountMap).