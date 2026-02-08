-module(solution).
-export([min_operations/1]).

min_operations(Nums) ->
    N = length(Nums),
    Sorted = lists:sort(Nums),
    Even = lists:filter(fun(X) -> X rem 2 == 0 end, Sorted),
    Odd = lists:filter(fun(X) -> X rem 2 /= 0 end, Sorted),
    EvenSorted = lists:sort(Even),
    OddSorted = lists:sort(Odd),
    EvenCount = length(Even),
    OddCount = length(Odd),
    EvenList = lists:seq(0, EvenCount - 1),
    OddList = lists:seq(0, OddCount - 1),
    EvenTarget = [X * 2 || X <- EvenList],
    OddTarget = [X * 2 + 1 || X <- OddList],
    lists:foldl(fun(I, Acc) -> Acc + abs(EvenSorted[I] - EvenTarget[I]) end, 0, lists:seq(0, EvenCount - 1)) +
    lists:foldl(fun(I, Acc) -> Acc + abs(OddSorted[I] - OddTarget[I]) end, 0, lists:seq(0, OddCount - 1)).