-module(sum_in_matrix).
-export([matrix_sum/1]).

matrix_sum(Nums) ->
    lists:sum([lists:max([lists:nth(I, Row) || Row <- Nums]) || I <- lists:seq(1, length(lists:nth(1, Nums)))]).