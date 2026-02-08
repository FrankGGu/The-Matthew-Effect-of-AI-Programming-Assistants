-module(solution).
-export([max_product/1]).

max_product(N) ->
    Digits = lists:map(fun (X) -> (N div (10#'0' + X)) rem 10 end, lists:seq(0, 9)),
    MaxProduct = lists:max(
        [X * Y || {X, I} <- lists:zip(Digits, lists:seq(1, length(Digits))),
                        {Y, J} <- lists:zip(Digits, lists:seq(1, length(Digits)), I < J)]
    ),
    MaxProduct.