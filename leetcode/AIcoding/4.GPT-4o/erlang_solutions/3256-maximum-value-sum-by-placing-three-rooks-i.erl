-module(solution).
-export([max_value/1]).

max_value(Board) ->
    Rows = length(Board),
    Cols = length(hd(Board)),
    Rooks = lists:seq(1, 3),
    MaxValue = lists:max([sum_values(Rooks, RookIndices, Board) || RookIndices <- lists:subsets(3, lists:seq(1, Rows * Cols))]),
    MaxValue.

sum_values([], _, _) -> 0;
sum_values([Rook | Rest], RookIndices, Board) ->
    {Row, Col} = index_to_coordinates(Rook, length(hd(Board))),
    Value = lists:nth(Row, lists:nth(Col, Board)),
    Value + sum_values(Rest, RookIndices, Board).

index_to_coordinates(Index, Cols) ->
    Row = (Index - 1) div Cols + 1,
    Col = (Index - 1) rem Cols + 1,
    {Row, Col}.

lists:subsets(0, _) -> [[]];
lists:subsets(N, L) when N > 0 -> 
    [H | T] = L,
    lists:subsets(N, T) ++ lists:map(fun(X) -> [H | X] end, lists:subsets(N - 1, T)).