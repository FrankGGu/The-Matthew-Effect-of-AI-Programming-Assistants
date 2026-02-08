-module(solution).
-export([min_ops/1]).

min_ops(Nums) ->
    min_ops(Nums, 0).

min_ops([], Acc) ->
    Acc;
min_ops([H | T], Acc) ->
    Rem = H rem 3,
    if
        Rem == 0 -> min_ops(T, Acc);
        true -> min_ops(T, Acc + (3 - Rem))
    end.