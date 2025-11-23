-module(largest_odd_number).
-export([largestOddNumber/1]).

largestOddNumber(Num) ->
  largestOddNumber(Num, length(Num) - 1).

largestOddNumber(Num, Index) when Index < 0 ->
  "";
largestOddNumber(Num, Index) ->
  Digit = list_to_integer([string:at(Num, Index + 1)]),
  if
    Digit rem 2 == 1 ->
      string:substr(Num, 1, Index + 1);
    true ->
      largestOddNumber(Num, Index - 1)
  end.