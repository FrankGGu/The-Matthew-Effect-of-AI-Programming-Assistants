-module(solution).
-export([count_digits/1]).

count_digits(Num) ->
  count_divisors(Num, Num, 0).

count_divisors(Num, N, Count) when N =:= 0 ->
  Count;
count_divisors(Num, N, Count) ->
  Digit = N rem 10,
  case Digit =/= 0 andalso Num rem Digit =:= 0 of
    true ->
      count_divisors(Num, N div 10, Count + 1);
    false ->
      count_divisors(Num, N div 10, Count)
  end.