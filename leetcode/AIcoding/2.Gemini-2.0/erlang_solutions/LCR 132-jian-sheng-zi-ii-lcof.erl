-module(cutting_bamboo_ii).
-export([min_cuts/1]).

min_cuts(heights) ->
  lists:foldl(fun(H, Acc) -> Acc + max(0, ceiling_div(H, Acc) - 1) end, 1, heights).

ceiling_div(A, B) ->
  (A + B - 1) div B.