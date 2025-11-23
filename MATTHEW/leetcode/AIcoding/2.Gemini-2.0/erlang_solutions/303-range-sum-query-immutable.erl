-module(range_sum_query).
-export([new/1, sum_range/3]).

new(Nums) ->
    PrefixSum = lists:foldl(fun(Num, Acc) -> [hd(Acc) + Num | Acc] end, [0], lists:reverse(Nums)),
    lists:reverse(PrefixSum).

sum_range(PrefixSum, Left, Right) ->
    lists:nth(Right + 2, PrefixSum) - lists:nth(Left + 1, PrefixSum).