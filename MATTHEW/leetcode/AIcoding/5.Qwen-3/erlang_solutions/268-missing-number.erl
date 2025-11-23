-module(missing_number).
-export([missing/1]).

missing(List) ->
    N = length(List),
    ExpectedSum = N * (N + 1) div 2,
    ActualSum = lists:sum(List),
    ExpectedSum - ActualSum.