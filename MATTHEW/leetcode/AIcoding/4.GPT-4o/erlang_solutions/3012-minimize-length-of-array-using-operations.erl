-module(solution).
-export([minimizeArrayLength/1]).

minimizeArrayLength(Numbers) ->
    UniqueNumbers = lists:usort(Numbers),
    length(UniqueNumbers).