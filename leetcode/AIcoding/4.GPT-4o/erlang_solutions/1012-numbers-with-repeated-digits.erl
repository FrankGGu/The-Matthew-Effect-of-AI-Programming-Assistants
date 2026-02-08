-module(solution).
-export([numDupDigitsAtMostN/1]).

numDupDigitsAtMostN(N) ->
    Digits = integer_to_list(N),
    Len = length(Digits),
    Count = calculate_count(Len - 1),
    UniqueCount = calculate_unique(Len, Digits),
    Count + UniqueCount.

calculate_count(0) -> 0;
calculate_count(Len) ->
    Sum = lists:foldl(fun(X, Acc) -> Acc + (9 * factorial(9 - X + 1)) end, 0, lists:seq(1, Len)) + 9 * factorial(9 - Len).

calculate_unique(Len, [H | T]) ->
    MaxDigit = list_to_integer(H) - 1,
    FirstChoice = lists:seq(1, MaxDigit),
    UniqueCount = lists:foldl(fun(X, Acc) -> Acc + (9 - length(FirstChoice) + 1) * factorial(9 - Len) end, 0, FirstChoice),
    DigitCount = lists:foldl(fun(D, Acc) -> if D < H -> Acc + 1; true -> Acc end end, 0, T),
    if DigitCount > 0 -> UniqueCount + 1; true -> UniqueCount end.

factorial(0) -> 1;
factorial(N) -> N * factorial(N - 1).