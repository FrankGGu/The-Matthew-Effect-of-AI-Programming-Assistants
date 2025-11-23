-module(shuffle).
-export([shuffle/2]).

shuffle(Nums, N) ->
    lists:foldl(
        fun(I, Acc) ->
            [lists:nth(I, Nums), lists:nth(I + N, Nums) | Acc]
        end,
        [],
        lists:seq(1, N)
    ).