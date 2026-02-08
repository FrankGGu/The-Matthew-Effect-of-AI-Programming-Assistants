-module(solution).
-export([maxDifference/1]).

maxDifference(Prices) ->
    Max = lists:max(Prices),
    Min = lists:min(Prices),
    Max - Min.