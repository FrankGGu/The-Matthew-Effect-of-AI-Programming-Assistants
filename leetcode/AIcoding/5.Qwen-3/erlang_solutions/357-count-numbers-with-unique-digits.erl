-module(solution).
-export([countNumbersWithUniqueDigits/1]).

countNumbersWithUniqueDigits(0) -> 1;
countNumbersWithUniqueDigits(N) when N >= 1 ->
    countNumbersWithUniqueDigits(N, 10, 1, 9).

countNumbersWithUniqueDigits(0, _, _, _) -> 1;
countNumbersWithUniqueDigits(N, Max, Acc, Available) ->
    if
        N == 1 -> Acc + Available;
        true ->
            countNumbersWithUniqueDigits(N - 1, Max, Acc * Available, Available - 1)
    end.