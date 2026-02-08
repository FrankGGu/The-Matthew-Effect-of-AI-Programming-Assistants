-module(n_repeated_element).
-export([repeated_element/1]).

repeated_element(Arr) ->
    Map = lists:foldl(fun(X, Acc) -> maps:update(X, maps:get(X, Acc, 0) + 1, Acc) end, maps:new(), Arr),
    lists:keyfind(2, 2, maps:to_list(Map)).