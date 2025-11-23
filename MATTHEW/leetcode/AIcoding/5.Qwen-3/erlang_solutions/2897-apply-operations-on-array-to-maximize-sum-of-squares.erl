-module(solution).
-export([max_sum_squares/1]).

max_sum_squares(Nums) ->
    lists:foldl(fun(X, Acc) -> Acc + X*X end, 0, Nums).