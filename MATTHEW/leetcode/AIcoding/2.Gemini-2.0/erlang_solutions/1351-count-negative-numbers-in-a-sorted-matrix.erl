-module(solution).
-export([count_negatives/1]).

count_negatives(Grid) ->
  count_negatives(Grid, 0).

count_negatives([], Acc) ->
  Acc;
count_negatives([Row | Rest], Acc) ->
  Acc1 = count_negatives_row(Row, 0),
  count_negatives(Rest, Acc + Acc1).

count_negatives_row(Row, Acc) ->
  count_negatives_row(Row, length(Row), Acc).

count_negatives_row(_, 0, Acc) ->
  Acc;
count_negatives_row([H | _], N, Acc) when H < 0 ->
  N + Acc;
count_negatives_row([_ | Rest], N, Acc) ->
  count_negatives_row(Rest, N - 1, Acc).