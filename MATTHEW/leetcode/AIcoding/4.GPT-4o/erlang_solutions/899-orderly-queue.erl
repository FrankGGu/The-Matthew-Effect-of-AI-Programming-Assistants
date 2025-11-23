-module(solution).
-export([orderlyQueue/2]).

orderlyQueue(S, K) when K == 1 ->
    lists:foldl(fun(X, Acc) -> min(X ++ Acc, Acc ++ X) end, S, lists:seq(1, length(S)));
orderlyQueue(S, K) ->
    lists:sort(lists:unlist(string:to_list(S))).