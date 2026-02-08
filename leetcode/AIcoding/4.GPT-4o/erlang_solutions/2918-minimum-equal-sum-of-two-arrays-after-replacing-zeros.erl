-module(solution).
-export([min_equal_sum/2]).

min_equal_sum(A, B) ->
    SumA = lists:sum(A),
    SumB = lists:sum(B),
    ZerosA = lists:length(lists:filter(fun(X) -> X == 0 end, A)),
    ZerosB = lists:length(lists:filter(fun(X) -> X == 0 end, B)),
    MinSum = min(SumA, SumB),
    RemainingZeros = ZerosA + ZerosB,
    MinSum - RemainingZeros.

min(X, Y) when X < Y -> X;
min(_, Y) -> Y.