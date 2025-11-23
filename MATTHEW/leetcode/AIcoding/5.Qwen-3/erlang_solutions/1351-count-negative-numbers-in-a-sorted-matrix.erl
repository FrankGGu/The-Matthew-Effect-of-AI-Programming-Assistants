-module(solution).
-export([count_negatives/1]).

count_negatives(Matrix) ->
    count_negatives(Matrix, 0).

count_negatives([], Count) ->
    Count;
count_negatives([Row | Rest], Count) ->
    Len = length(Row),
    count_negatives(Rest, Count + count_negatives_row(Row, Len, 0)).

count_negatives_row([], _, Count) ->
    Count;
count_negatives_row([H | T], Len, Count) when H < 0 ->
    count_negatives_row(T, Len, Count + 1);
count_negatives_row([H | T], Len, Count) ->
    count_negatives_row(T, Len, Count).