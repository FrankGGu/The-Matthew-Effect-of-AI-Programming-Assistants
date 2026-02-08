-module(unique_digits).
-export([countNumbersWithUniqueDigits/1]).

countNumbersWithUniqueDigits(N) ->
  case N of
    0 -> 1;
    1 -> 10;
    _ ->
      UniqueDigits = min(N, 10),
      calculate(UniqueDigits, 10, 9, 1)
  end.

calculate(0, _, _, Acc) ->
  Acc;
calculate(UniqueDigits, AvailableDigits, Result, Acc) ->
  NewResult = Result * AvailableDigits,
  calculate(UniqueDigits - 1, AvailableDigits - 1, NewResult, Acc + NewResult).