-module(solution).
-export([get_sum_absolute_differences/1]).

get_sum_absolute_differences(Nums) ->
    N = length(Nums),
    PrefixSum = lists:foldl(fun(X, Acc) -> [X + hd(Acc)] ++ Acc end, [0], lists:reverse(Nums)),
    lists:map(fun(X) -> abs(X * N - 2 * hd(PrefixSum)) end, Nums).