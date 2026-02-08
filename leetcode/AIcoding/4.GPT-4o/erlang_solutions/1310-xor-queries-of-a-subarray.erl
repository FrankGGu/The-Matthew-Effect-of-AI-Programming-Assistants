-module(solution).
-export([xorQueries/2]).

xorQueries(A, Queries) ->
    PrefixXor = lists:foldl(fun(X, Acc) -> [X bxor hd(Acc)| Acc] end, [0], A),
    lists:map(fun({L, R}) -> lists:nth(R + 1, PrefixXor) bxor lists:nth(L, PrefixXor) end, Queries).