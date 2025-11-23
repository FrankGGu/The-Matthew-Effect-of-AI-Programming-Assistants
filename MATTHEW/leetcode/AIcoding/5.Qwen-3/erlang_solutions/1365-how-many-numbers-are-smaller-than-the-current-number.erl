-module(solution).
-export([smallerNumbersThanCurrent/1]).

smallerNumbersThanCurrent(Nums) ->
    Lists = lists:seq(0, length(Nums) - 1),
    [lists:foldl(fun(X, Acc) -> if X < Nums ! I -> Acc + 1; true -> Acc end end, 0, Nums) || I <- Lists].

Nums ! I ->
    lists:nth(I + 1, Nums).