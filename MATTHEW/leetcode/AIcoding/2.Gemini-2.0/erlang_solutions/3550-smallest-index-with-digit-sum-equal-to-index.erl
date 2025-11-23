-module(smallest_index_with_digit_sum_equal_to_index).
-export([smallest_equal/1]).

smallest_equal(Nums) ->
  smallest_equal(Nums, 0).

smallest_equal([], _Index) ->
  -1;
smallest_equal([H|T], Index) ->
  DigitSum = digit_sum(Index),
  if DigitSum =:= (H rem 10) then
    Index
  else
    smallest_equal(T, Index + 1)
  end.

digit_sum(0) ->
  0;
digit_sum(N) ->
  (N rem 10) + digit_sum(N div 10).