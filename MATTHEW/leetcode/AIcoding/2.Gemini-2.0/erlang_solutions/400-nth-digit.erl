-module(nth_digit).
-export([findNthDigit/1]).

findNthDigit(N) ->
  findNthDigit(N, 1, 9, 1).

findNthDigit(N, DigitLength, CountOfNumbers, StartOfNumbers) ->
  if N > DigitLength * CountOfNumbers ->
    findNthDigit(N - DigitLength * CountOfNumbers, DigitLength + 1, CountOfNumbers * 10, StartOfNumbers * 10);
  true ->
    NumberIndex = (N - 1) div DigitLength,
    DigitIndex = (N - 1) rem DigitLength,
    Number = StartOfNumbers + NumberIndex,
    NumberString = integer_to_list(Number),
    list_to_integer([lists:nth(DigitIndex + 1, NumberString)])
  end.