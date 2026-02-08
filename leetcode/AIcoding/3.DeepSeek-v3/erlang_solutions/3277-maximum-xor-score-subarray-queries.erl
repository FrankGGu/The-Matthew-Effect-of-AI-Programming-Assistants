-module(solution).
-export([max_xor_subarray/2]).

max_xor_subarray(Nums, Queries) ->
    Prefix = lists:foldl(fun(X, Acc) -> [hd(Acc) bxor X | Acc] end, [0], Nums),
    PrefixList = lists:reverse(Prefix),
    lists:map(fun({L, R}) -> 
        lists:max([lists:nth(L + 1, PrefixList) bxor lists:nth(R + 1, PrefixList)])
    end, Queries).