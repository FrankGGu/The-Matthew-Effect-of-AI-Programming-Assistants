-module(solution).
-export([countBitChanges/2]).

countBitChanges(X, Y) ->
    BitDiff = X bxor Y,
    countSetBits(BitDiff).

countSetBits(0) -> 0;
countSetBits(N) -> (N band 1) + countSetBits(N bsr 1).