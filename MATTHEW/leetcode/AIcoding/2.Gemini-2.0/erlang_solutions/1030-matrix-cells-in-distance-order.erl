-module(matrix_cells_in_distance_order).
-export([all_cells_dist_order/3]).

all_cells_dist_order(R, C, [r0, c0]) ->
  Cells = lists:flatten([[ {Row, Col} || Col <- lists:seq(0, C-1) ] || Row <- lists:seq(0, R-1)]),
  lists:keysort(1, [{distance({r0, c0}, Cell), Cell} || Cell <- Cells]).

distance({R1, C1}, {R2, C2}) ->
  abs(R1 - R2) + abs(C1 - C2).