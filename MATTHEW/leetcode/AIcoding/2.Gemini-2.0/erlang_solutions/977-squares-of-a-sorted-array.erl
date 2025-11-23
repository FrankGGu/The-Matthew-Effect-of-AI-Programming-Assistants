-module(squares_of_a_sorted_array).
-export([sortedSquares/1]).

sortedSquares(A) ->
  N = length(A),
  sortedSquaresHelper(A, 0, N - 1, []).

sortedSquaresHelper(A, L, R, Acc) when L > R ->
  lists:reverse(Acc);
sortedSquaresHelper(A, L, R, Acc) ->
  LeftSq = (lists:nth(L + 1, A)) * (lists:nth(L + 1, A)),
  RightSq = (lists:nth(R + 1, A)) * (lists:nth(R + 1, A)),
  if
    LeftSq > RightSq ->
      sortedSquaresHelper(A, L + 1, R, [LeftSq | Acc]);
    true ->
      sortedSquaresHelper(A, L, R - 1, [RightSq | Acc])
  end.