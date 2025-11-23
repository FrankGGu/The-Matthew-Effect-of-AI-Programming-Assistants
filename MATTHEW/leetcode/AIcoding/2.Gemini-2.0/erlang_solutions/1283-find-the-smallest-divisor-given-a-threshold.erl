-module(smallest_divisor).
-export([smallestDivisor/2]).

smallestDivisor(Nums, Threshold) ->
    smallestDivisorHelper(Nums, Threshold, 1, lists:max(Nums)).

smallestDivisorHelper(Nums, Threshold, Low, High) ->
    if Low > High ->
        Low;
    true ->
        Mid = (Low + High) div 2,
        Sum = sumDivided(Nums, Mid),
        if Sum > Threshold ->
            smallestDivisorHelper(Nums, Threshold, Mid + 1, High);
        true ->
            smallestDivisorHelper(Nums, Threshold, Low, Mid - 1)
    end.

sumDivided(Nums, Divisor) ->
    lists:sum([math:ceil(X / Divisor) || X <- Nums]).