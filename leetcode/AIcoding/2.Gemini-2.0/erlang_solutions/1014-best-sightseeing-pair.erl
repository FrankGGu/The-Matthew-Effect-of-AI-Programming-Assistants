-module(best_sightseeing_pair).
-export([max_score_sightseeing_pair/1]).

max_score_sightseeing_pair(Values) ->
    max_score_sightseeing_pair(Values, 0, 0).

max_score_sightseeing_pair([H | T], MaxSoFar, Result) ->
    NewResult = max(Result, MaxSoFar + H),
    NewMaxSoFar = max(MaxSoFar, H + length(T) + 1),
    max_score_sightseeing_pair(T, NewMaxSoFar, NewResult);
max_score_sightseeing_pair([], _, Result) ->
    Result.