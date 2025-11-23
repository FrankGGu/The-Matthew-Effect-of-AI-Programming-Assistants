-module(hammingWeight).
-export([hammingWeight/1]).

hammingWeight(N) ->
    hammingWeight(N, 0).

hammingWeight(0, Count) ->
    Count;
hammingWeight(N, Count) ->
    hammingWeight(N band (N - 1), Count + 1).