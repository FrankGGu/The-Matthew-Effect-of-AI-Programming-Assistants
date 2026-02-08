-module(smallest_divisible_digit_product_i).
-export([smallest_number/1]).

smallest_number(N) ->
  smallest_number_helper(N, []).

smallest_number_helper(0, Digits) ->
  list_to_integer(lists:reverse(Digits));
smallest_number_helper(1, Digits) ->
  list_to_integer(lists:reverse(Digits));
smallest_number_helper(N, Digits) ->
  case find_smallest_divisor(N) of
    no_divisor ->
      -1;
    Divisor ->
      smallest_number_helper(N div Divisor, [Divisor | Digits])
  end.

find_smallest_divisor(N) ->
  find_smallest_divisor_helper(N, 2).

find_smallest_divisor_helper(N, Divisor) when Divisor > 9 ->
  no_divisor;
find_smallest_divisor_helper(N, Divisor) ->
  if N rem Divisor == 0 ->
    Divisor;
  true ->
    find_smallest_divisor_helper(N, Divisor + 1)
  end.