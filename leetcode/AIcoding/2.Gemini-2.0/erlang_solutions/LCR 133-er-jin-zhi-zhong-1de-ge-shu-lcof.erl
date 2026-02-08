-module(hammingWeight).
-export([hammingWeight/1]).

hammingWeight(N) ->
    hammingWeight(N, 0).

hammingWeight(0, Acc) ->
    Acc;
hammingWeight(N, Acc) ->
    hammingWeight(N band (N - 1), Acc + 1).