-module(solution).
-export([uniqueOccurrences/1]).

uniqueOccurrences(List) ->
    Counts = lists:foldl(fun(X, Acc) -> 
        maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc) 
    end, maps:new(), List),
    Occurrences = maps:fold(fun(_, Val, Acc) -> lists:append([Val], Acc) end, [], Counts),
    UniqueOccurrences = lists:usort(Occurrences),
    length(Occurrences) =:= length(UniqueOccurrences).