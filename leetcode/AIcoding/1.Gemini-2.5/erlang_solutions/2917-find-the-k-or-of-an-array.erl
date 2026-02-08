-module(solution).
-export([findKOr/2]).

findKOr(Nums, K) ->
    lists:foldl(
        fun(Num, Acc) ->
            case ((Num bsr K) band 1) of
                1 -> Acc bor Num;
                _ -> Acc
            end
        end,
        0,
        Nums
    ).