-module(solution).
-export([sort_by_parity/1]).

sort_by_parity(Nums) ->
    Even = [X || X <- Nums, X rem 2 == 0],
    Odd = [X || X <- Nums, X rem 2 == 1],
    Even ++ Odd.