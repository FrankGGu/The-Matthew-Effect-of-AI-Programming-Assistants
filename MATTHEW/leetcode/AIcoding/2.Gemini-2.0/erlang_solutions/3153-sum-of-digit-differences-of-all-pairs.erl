-module(digit_diff_sum).
-export([digit_diff_sum/1]).

digit_diff_sum(Nums) ->
  Len = length(Nums),
  sum([abs(digit_sum(lists:nth(I, Nums)) - digit_sum(lists:nth(J, Nums))) || I <- lists:seq(1, Len), J <- lists:seq(I+1, Len)]).

digit_sum(N) ->
  digit_sum_helper(N, 0).

digit_sum_helper(0, Acc) ->
  Acc;
digit_sum_helper(N, Acc) ->
  digit_sum_helper(N div 10, Acc + (N rem 10)).