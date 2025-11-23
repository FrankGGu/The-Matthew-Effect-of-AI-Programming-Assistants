-module(solution).
-export([are_occurrences_equal/1]).

are_occurrences_equal(Str) ->
    Count = lists:foldl(fun(Char, Acc) -> 
        maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc) 
    end, #{}, Str),
    Values = maps:values(Count),
    lists:all(fun(V) -> V == lists:hd(Values) end, Values).