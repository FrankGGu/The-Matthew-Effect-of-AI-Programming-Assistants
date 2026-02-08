-module(maximum_score).
-export([max_score/1]).

max_score(Grid) ->
  max_score_helper(Grid, 0, 0, 0).

max_score_helper([], _, Max, Acc) ->
  max(Max, Acc);
max_score_helper([Row | Rest], RowIndex, Max, Acc) ->
  {NewMax, NewAcc} = max_score_row(Row, RowIndex, 0, Max, Acc, 0),
  max_score_helper(Rest, RowIndex + 1, NewMax, NewAcc).

max_score_row([], _, _, Max, Acc, _) ->
  {Max, Acc};
max_score_row([Cell | Rest], RowIndex, ColIndex, Max, Acc, Bit) ->
  NewBit = bitwise_xor(Bit, 1),
  Score = case NewBit of
    0 -> Cell;
    1 -> 0
  end,
  NewAcc = Acc + Score,
  NewMax = max(Max, NewAcc),
  max_score_row(Rest, RowIndex, ColIndex + 1, NewMax, NewAcc, NewBit).

bitwise_xor(X, Y) ->
  X bxor Y.

max(X, Y) ->
  if X > Y -> X;
     true -> Y
  end.