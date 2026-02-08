-module(k_items_with_maximum_sum).
-export([k_items_with_maximum_sum/4]).

k_items_with_maximum_sum(NumOnes, NumZeros, NumNegOnes, K) ->
    Ones = min(NumOnes, K),
    K1 = K - Ones,
    Zeros = min(NumZeros, K1),
    K2 = K1 - Zeros,
    NegOnes = min(NumNegOnes, K2),
    Ones - NegOnes.