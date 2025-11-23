-module(minimum_absolute_difference).
-export([min_absolute_difference/3]).

min_absolute_difference(Nums, X, Result) ->
    min_absolute_difference(Nums, X, 0, length(Nums) - 1, Result).

min_absolute_difference(Nums, X, I, J, Result) ->
    case I >= length(Nums) - X orelse J < X  of
        true -> Result;
        false ->
            MinDiff = lists:foldl(
                fun(K, Acc) ->
                    case K + X > J of
                        true -> Acc;
                        false ->
                            Diff = abs(lists:nth(K, Nums) - lists:nth(K+X, Nums)),
                            min(Acc, Diff)
                    end
                end,
                Result,
                lists:seq(I, J - X)
            ),
            min_absolute_difference(Nums, X, I+1, J, MinDiff)
    end.

min_absolute_difference(Nums, X) ->
    min_absolute_difference(Nums, X, 1000000000).