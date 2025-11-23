-module(solution).
-export([canBeEqual/1]).

canBeEqual(Digits) ->
    Count = lists:foldl(fun(D, Acc) -> maps:update_with(D, fun(V) -> V + 1 end, 1, Acc) end, #{}, Digits),
    lists:all(fun({K, V}) -> K == V end, maps:to_list(Count)).