-module(solve).
-export([hammingWeight/1]).

hammingWeight(N) ->
    hammingWeight(N, 0).

hammingWeight(0, Count) ->
    Count;
hammingWeight(N, Count) ->
    hammingWeight(N bsr 1, Count + (N band 1)).