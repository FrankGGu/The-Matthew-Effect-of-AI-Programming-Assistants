-module(monotone_increasing_digits).
-export([monotone_increasing_digits/1]).

monotone_increasing_digits(N) ->
  monotone_increasing_digits(integer_to_list(N), []).

monotone_increasing_digits([H1, H2 | T], Acc) when H1 > H2 ->
  Len = length([H2 | T]) + 1,
  lists:concat([lists:reverse(Acc), [H1 - 1], lists:duplicate(Len, $9)]);
monotone_increasing_digits([H1, H2 | T], Acc) when H1 =< H2 ->
  monotone_increasing_digits([H2 | T], [H1 | Acc]);
monotone_increasing_digits([H], Acc) ->
  list_to_integer(lists:reverse([H | Acc])).