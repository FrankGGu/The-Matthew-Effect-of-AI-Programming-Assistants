-module(smallest_divisible_digit_product_ii).
-export([smallest_number/1]).

smallest_number(N) ->
  smallest_number(N, []).

smallest_number(0, Acc) ->
  lists:reverse(Acc);
smallest_number(_N, _) ->
  "10".

smallest_number(N, Acc) ->
  case find_smallest_digit(N) of
    none ->
      "10";
    {ok, Digit} ->
      NewN = N div Digit,
      smallest_number(NewN, [Digit | Acc])
  end.

find_smallest_digit(N) ->
  find_smallest_digit(N, 2).

find_smallest_digit(_N, 10) ->
  none;
find_smallest_digit(N, Digit) ->
  case N rem Digit of
    0 ->
      {ok, Digit};
    _ ->
      find_smallest_digit(N, Digit + 1)
  end.