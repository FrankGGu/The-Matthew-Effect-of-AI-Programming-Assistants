-module(solution).
-export([distinctNames/1]).

distinctNames(Ideas) ->
    UniquePrefixes = lists:map(fun(X) -> unique_prefix(X, Ideas) end, Ideas),
    lists:sum(UniquePrefixes).

unique_prefix(_, Ideas) ->
    Unique = fun(X) -> lists:filter(fun(Y) -> lists:nth(1, Y) =:= lists:nth(1, X) end, Ideas) end,
    Fun = fun(X) -> lists:filter(fun(Y) -> lists:nth(1, Y) =/= lists:nth(1, X) end, Ideas) end,
    lists:foldl(fun(X, Acc) -> Acc + lists:length(Fun(X)) end, 0, Unique).