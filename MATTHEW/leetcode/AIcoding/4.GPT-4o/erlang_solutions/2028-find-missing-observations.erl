-module(solution).
-export([find_missing_observations/2]).

find_missing_observations(Observed, Total) ->
    ExpectedSum = lists:sum(lists:seq(1, Total)),
    ObservedSum = lists:sum(Observed),
    ExpectedSum - ObservedSum.