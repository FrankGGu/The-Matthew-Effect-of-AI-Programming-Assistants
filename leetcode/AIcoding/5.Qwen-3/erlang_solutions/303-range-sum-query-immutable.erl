-module(rangesumqueryimmutable).
-export([new/1, sum_range/2]).

new(Nums) ->
    Len = length(Nums),
    Prefix = lists:seq(0, Len),
    PrefixSum = lists:foldl(fun(I, Acc) -> 
        [lists:nth(I, Nums) + hd(Acc) | Acc] 
    end, [0], lists:seq(1, Len)),
    {prefix_sum, lists:reverse(PrefixSum)}.

sum_range({prefix_sum, Prefix}, Left, Right) ->
    lists:nth(Right + 1, Prefix) - lists:nth(Left, Prefix).