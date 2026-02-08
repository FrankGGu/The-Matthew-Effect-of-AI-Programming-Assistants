-module(solution).
-export([minimum_cost/2]).

minimum_cost(S, T) ->
    lists:foldl(fun({C1, C2}, Acc) -> Acc + if C1 /= C2 -> 1; true -> 0 end end, 0, lists:zip(lists:seq(1, string:length(S)), lists:seq(1, string:length(T)))).