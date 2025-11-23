-module(solution).
-export([max_sum/2]).

max_sum(Nums, K) ->
    Sorted = lists:sort(fun(A, B) -> A >= B end, Nums),
    {Res, _} = lists:foldl(fun(_, {Acc, RemK}) when RemK =< 0 -> {Acc, 0};
                              (Num, {Acc, RemK}) -> {Acc + Num * Num, RemK - 1} end,
                           {0, K}, Sorted),
    Res.