-module(solution).
-export([areOccurrencesEqual/1]).

areOccurrencesEqual(S) ->
    Counts = maps:fold(fun(C, Acc) -> maps:update_with(C, fun(X) -> X + 1 end, fun() -> 1 end, Acc) end, #{}, string:to_list(S)),
    Values = maps:values(Counts),
    lists:all(fun(X) -> X =:= hd(Values) end, Values).