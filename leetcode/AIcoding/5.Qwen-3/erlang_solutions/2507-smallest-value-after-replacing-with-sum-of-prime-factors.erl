-module(solution).
-export([findSmallestValue/1]).

findSmallestValue(N) ->
    findSmallestValue(N, 0).

findSmallestValue(1, _) ->
    1;
findSmallestValue(N, Acc) ->
    Sum = sumOfPrimeFactors(N),
    if
        Sum == N ->
            N;
        true ->
            findSmallestValue(Sum, Acc + 1)
    end.

sumOfPrimeFactors(N) ->
    sumOfPrimeFactors(N, 2, 0).

sumOfPrimeFactors(N, Div, Sum) when Div * Div > N ->
    if
        N > 1 -> Sum + N;
        true -> Sum
    end;
sumOfPrimeFactors(N, Div, Sum) ->
    case N rem Div of
        0 ->
            sumOfPrimeFactors(N div Div, Div, Sum + Div);
        _ ->
            sumOfPrimeFactors(N, Div + 1, Sum)
    end.