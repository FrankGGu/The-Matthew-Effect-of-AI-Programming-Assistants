-module(solution).
-export([maximum_difference/1]).

maximum_difference(List) ->
    maximum_difference(List, infinity, 0).

maximum_difference([], _, MaxDiff) ->
    MaxDiff;
maximum_difference([H | T], Min, MaxDiff) when H > Min ->
    maximum_difference(T, Min, max(MaxDiff, H - Min));
maximum_difference([H | T], Min, MaxDiff) ->
    maximum_difference(T, min(Min, H), MaxDiff).