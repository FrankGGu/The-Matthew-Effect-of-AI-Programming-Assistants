-module(solution).
-export([sumBase/2]).

sumBase(N, K) ->
    sumBase_recursive(N, K, 0).

sumBase_recursive(0, _K, Acc) ->
    Acc;
sumBase_recursive(N, K, Acc) ->
    Digit = N rem K,
    RemainingN = N div K,
    sumBase_recursive(RemainingN, K, Acc + Digit).