-module(even_digit_sum).
-export([count_even/1]).

count_even(Num) ->
  count_even(1, Num, 0).

count_even(N, Num, Acc) when N > Num ->
  Acc;
count_even(N, Num, Acc) ->
  Digits = integer_to_list(N),
  Sum = lists:foldl(fun(D, S) -> S + (D - $0) end, 0, Digits),
  case Sum rem 2 of
    0 ->
      count_even(N + 1, Num, Acc + 1);
    _ ->
      count_even(N + 1, Num, Acc)
  end.