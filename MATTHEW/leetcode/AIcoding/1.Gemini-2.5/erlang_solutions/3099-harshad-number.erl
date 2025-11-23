-module(solution).
-export([sumOfTheDigitsOfHarshadNumber/1]).

sumOfTheDigitsOfHarshadNumber(X) ->
    SumDigits = sum_digits(X, 0),
    if
        X rem SumDigits == 0 ->
            X;
        true ->
            -1
    end.

sum_digits(0, Acc) -> Acc;
sum_digits(N, Acc) -> sum_digits(N div 10, Acc + (N rem 10)).