-module(difference_between_ones_and_zeros).
-export([solve/1]).

solve(Matrix) ->
  Rows = length(Matrix),
  Cols = length(hd(Matrix)),

  RowOnes = [lists:sum([I || I <- Row]) || Row <- Matrix],
  ColOnes = [lists:sum([Matrix[Row][Col] || Row <- lists:seq(1, Rows)]) || Col <- lists:seq(1, Cols)],

  [[calculate_diff(RowOnes[Row-1], ColOnes[Col-1], Rows, Cols) || Col <- lists:seq(1, Cols)] || Row <- lists:seq(1, Rows)].

calculate_diff(RowOnes, ColOnes, Rows, Cols) ->
  RowOnes + ColOnes - (Rows - RowOnes) - (Cols - ColOnes).