-module(lucky_numbers_in_a_matrix).
-export([lucky_numbers/1]).

lucky_numbers(Matrix) ->
    Rows = length(Matrix),
    Cols = length(hd(Matrix)),
    MinInRow = [lists:min(Row) || Row <- Matrix],
    MaxInCol = [lists:foldl(fun(E, Acc) -> max(E, Acc) end, -inf, [lists:nth(Col, Row) || Row <- Matrix]) || Col <- lists:seq(1, Cols)],
    [Num || {RowIdx, Num} <- lists:enumerate(MinInRow), lists:member(Num, MaxInCol)].

lists:enumerate(List) ->
    lists:zipwith(fun(I, E) -> {I, E} end, lists:seq(1, length(List)), List).