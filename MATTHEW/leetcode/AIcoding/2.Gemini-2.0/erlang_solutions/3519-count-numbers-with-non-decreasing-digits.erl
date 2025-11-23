-module(non_decreasing_digits).
-export([find_non_decreasing_numbers/1]).

find_non_decreasing_numbers(N) ->
  count_non_decreasing(N).

count_non_decreasing(N) ->
  count_non_decreasing(integer_to_list(N), 0, 0).

count_non_decreasing([], _, Count) ->
  Count + 1;
count_non_decreasing([Digit | Rest], PreviousDigit, Count) ->
  DigitValue = list_to_integer([Digit]),

  case DigitValue >= PreviousDigit of
    true ->
      NewCount = count_from_digit(length([Digit|Rest]), PreviousDigit),
      count_non_decreasing(Rest, DigitValue, Count + NewCount);
    false ->
      0
  end.

count_from_digit(Length, StartDigit) ->
  case Length of
    0 -> 1;
    _ ->
      lists:sum([count_from_digit(Length - 1, D) || D <- lists:seq(StartDigit, 9)])
  end.