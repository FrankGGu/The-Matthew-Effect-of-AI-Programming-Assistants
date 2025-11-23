-module(matrix_diagonal_sum).
-export([diagonal_sum/1]).

diagonal_sum(Mat) ->
  N = length(Mat),
  diagonal_sum_helper(Mat, 0, 0, N, 0).

diagonal_sum_helper(_, N, _, N, Acc) ->
  Acc;
diagonal_sum_helper(Mat, I, J, N, Acc) ->
  NewAcc = Acc + lists:nth(J + 1, lists:nth(I + 1, Mat)),
  SecondaryIndex = N - 1 - I,
  if SecondaryIndex == J ->
    diagonal_sum_helper(Mat, I + 1, J + 1, N, NewAcc)
  else
    NewAcc2 = NewAcc + lists:nth(SecondaryIndex + 1, lists:nth(I + 1, Mat)),
    diagonal_sum_helper(Mat, I + 1, J + 1, N, NewAcc2)
  end.