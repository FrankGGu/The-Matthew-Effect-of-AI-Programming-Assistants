-module(solution).
-export([find_non_min_or_max/1]).

find_non_min_or_max([]) -> [];
find_non_min_or_max([_]) -> [];
find_non_min_or_max([_, _]) -> [];
find_non_min_or_max(List) ->
    Min = lists:min(List),
    Max = lists:max(List),
    [X || X <- List, X =/= Min, X =/= Max].