-module(solution).
-export([minimum_operations/1]).

minimum_operations(Array) ->
    UniqueElements = lists:usort(Array),
    case UniqueElements of
        [] -> 0;
        _ -> length(UniqueElements) - 1
    end.