-module(solution).
-export([max_and_sum/1]).

max_and_sum(Nums) ->
    N = length(Nums),
    MaxBits = 30,
    Sum = 0,
    lists:foldl(fun(Bit, Acc) ->
        Mask = 1 bsl Bit,
        Count = lists:foldl(fun(X, C) -> if (X band Mask) /= 0 -> C + 1; true -> C end end, 0, Nums),
        if Count >= 2 -> Acc + (Mask * (Count - 1)); true -> Acc end
    end, Sum, lists:seq(0, MaxBits)).