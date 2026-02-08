-module(split_with_minimum_sum).
-export([splitNum/1]).

splitNum(N) ->
  Digits = lists:sort(integer_to_list(N)),
  {Num1, Num2} = split_digits(Digits, [], []),
  list_to_integer(lists:reverse(Num1)) + list_to_integer(lists:reverse(Num2)).

split_digits([], Num1, Num2) ->
  {Num1, Num2};
split_digits([H|T], Num1, Num2) ->
  split_digits(T, Num2 ++ [H], Num1).