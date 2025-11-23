-module(solution).
-export([k_items_with_maximum_sum/4]).

k_items_with_maximum_sum(NumOnes, NumZeros, NumNegOnes, K) ->
    PickedOnes = min(K, NumOnes),
    Sum = PickedOnes,
    RemainingK = K - PickedOnes,

    PickedZeros = min(RemainingK, NumZeros),
    RemainingKAfterZeros = RemainingK - PickedZeros,

    PickedNegOnes = min(RemainingKAfterZeros, NumNegOnes),
    Sum - PickedNegOnes.