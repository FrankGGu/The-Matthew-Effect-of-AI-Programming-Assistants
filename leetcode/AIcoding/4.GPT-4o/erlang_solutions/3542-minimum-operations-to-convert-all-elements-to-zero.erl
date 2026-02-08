-module(solution).
-export([minimum_operations/1]).

minimum_operations(List) ->
    lists:foldl(fun(X, Acc) -> Acc + erlang:bit_size(X) end, 0, List).