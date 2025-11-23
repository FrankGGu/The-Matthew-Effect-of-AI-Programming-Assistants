-module(solution).
-export([count_max_frequency/1]).

count_max_frequency(List) ->
    Frequency = lists:foldl(fun(X, Acc) -> maps:update_with(X, fun(Count) -> Count + 1 end, 1, Acc) end, #{}, List),
    MaxFreq = lists:max(maps:values(Frequency)),
    lists:foldl(fun({Key, Value}, Acc) -> if Value =:= MaxFreq -> Acc + 1; true -> Acc end end, 0, maps:to_list(Frequency).