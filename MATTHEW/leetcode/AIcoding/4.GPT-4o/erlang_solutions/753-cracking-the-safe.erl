-module(solution).
-export([crack_safe/2]).

crack_safe(N, K) ->
    Codes = lists:seq(0, lists:foldl(fun(X, Acc) -> Acc * K + 1 end, 0, lists:seq(1, N)) - 1),
    Result = lists:map(fun(X) -> integer_to_list(X, K) end, Codes),
    lists:flatten(Result).