-module(min_operations).
-export([min_operations/1]).

min_operations(S) ->
    Count = lists:foldl(fun(Char, Acc) -> maps:update_with(Char, fun(X) -> X + 1 end, 1, Acc) end, #{}, S),
    Values = maps:values(Count),
    Max = lists:max(Values),
    Total = lists:sum(Values),
    Length = length(S),
    lists:foldl(fun(V, Acc) -> Acc + (Max - V) end, 0, Values).