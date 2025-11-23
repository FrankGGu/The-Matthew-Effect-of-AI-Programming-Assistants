-module(solution).
-export([row_with_maximum_ones/1]).

row_with_maximum_ones(Mat) ->
    find_max_ones(Mat, 0, 0, 0).

find_max_ones([], _CurrentRowIndex, MaxOnes, ResultRowIndex) ->
    [ResultRowIndex, MaxOnes];
find_max_ones([H|T], CurrentRowIndex, AccMaxOnes, AccResultRowIndex) ->
    CurrentOnes = count_ones(H),
    if
        CurrentOnes > AccMaxOnes ->
            find_max_ones(T, CurrentRowIndex + 1, CurrentOnes, CurrentRowIndex);
        true ->
            find_max_ones(T, CurrentRowIndex + 1, AccMaxOnes, AccResultRowIndex)
    end.

count_ones(Row) ->
    length([X || X <- Row, X == 1]).