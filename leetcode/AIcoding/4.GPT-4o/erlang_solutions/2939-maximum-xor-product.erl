-module(solution).
-export([max_xor_product/1]).

max_xor_product(Numbers) ->
    Max = lists:max(Numbers),
    lists:foldl(fun(X, Acc) -> max(Acc, X bxor Max) end, 0, Numbers).