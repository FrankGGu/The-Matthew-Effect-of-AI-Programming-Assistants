-module(solution).
-export([can_be_sorted/1]).

can_be_sorted(Array) ->
    SortedArray = lists:sort(Array),
    Array =:= SortedArray.