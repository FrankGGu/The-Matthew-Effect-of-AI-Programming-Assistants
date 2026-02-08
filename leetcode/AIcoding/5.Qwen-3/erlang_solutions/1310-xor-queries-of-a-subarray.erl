-module(solution).
-export([xor_subarray/2]).

xor_subarray(Nums, Queries) ->
    Prefix = lists:foldl(fun(N, Acc) -> [lists:last(Acc) bxor N | Acc] end, [0], Nums),
    lists:map(fun({L, R}) -> lists:nth(R + 1, Prefix) bxor lists:nth(L, Prefix) end, Queries).