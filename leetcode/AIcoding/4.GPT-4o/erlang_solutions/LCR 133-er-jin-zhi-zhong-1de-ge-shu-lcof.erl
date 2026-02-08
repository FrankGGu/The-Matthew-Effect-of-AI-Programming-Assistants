-module(solution).
-export([hammingWeight/1]).

hammingWeight(N) ->
    hammingWeight(N, 0).

hammingWeight(0, Count) ->
    Count;
hammingWeight(N, Count) ->
    hammingWeight(bsr(N, 1), Count + band(N, 1)).