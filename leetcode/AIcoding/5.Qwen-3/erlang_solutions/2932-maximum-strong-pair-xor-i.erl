-module(maximum_strong_pair_xor_i).
-export([maximumStrongPairXOR/1]).

maximumStrongPairXOR(Nums) ->
    lists:max([X BXorY || X <- Nums, Y <- Nums, abs(X - Y) =< min(X, Y)]).

BXorY -> X BXor Y.