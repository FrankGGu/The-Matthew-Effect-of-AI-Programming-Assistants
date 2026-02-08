-module(solution).
-export([max_equal_components/1]).

max_equal_components(Values) ->
    Count = lists:foldl(fun(V, Acc) -> maps:update_with(V, fun(X) -> X + 1 end, 1, Acc) end, maps:new(), Values),
    lists:foldl(fun({_, C}, Acc) -> Acc + (C rem 2) end, 0, maps:to_list(Count)).