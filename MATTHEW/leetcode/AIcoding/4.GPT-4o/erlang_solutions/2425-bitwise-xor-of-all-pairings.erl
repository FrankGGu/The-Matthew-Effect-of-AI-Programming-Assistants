-module(solution).
-export([xor_all_pairs/1]).

xor_all_pairs(List) ->
    N = length(List),
    Sum = lists:foldl(fun(X, Acc) -> Acc + X end, 0, List),
    XorSum = lists:foldl(fun(X, Acc) -> Acc bxor (Sum - X) end, 0, List),
    XorSum.