-module(solution).
-export([xor_beauty/1]).

xor_beauty(List) ->
    XorSum = lists:foldl(fun(X, Acc) -> Acc bxor X end, 0, List),
    lists:foldl(fun(X, Acc) -> Acc + (X bxor XorSum) end, 0, List).