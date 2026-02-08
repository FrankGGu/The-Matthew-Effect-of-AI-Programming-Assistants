-module(contains_duplicate).
-export([contains_duplicate/1]).

contains_duplicate(List) ->
    Set = sets:from_list(List),
    sets:size(Set) /= length(List).