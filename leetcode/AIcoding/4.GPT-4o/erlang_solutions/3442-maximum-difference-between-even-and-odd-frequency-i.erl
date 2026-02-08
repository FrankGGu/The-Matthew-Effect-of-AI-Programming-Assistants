-module(solution).
-export([maximum_difference/1]).

maximum_difference(List) ->
    Frequency = lists:foldl(fun(X, Acc) ->
        Map = maps:update_with(X, fun(Val) -> Val + 1 end, 1, Acc)
    end, #{}, List),
    EvenFreq = maps:filter(fun(_, V) -> V rem 2 == 0 end, Frequency),
    OddFreq = maps:filter(fun(_, V) -> V rem 2 == 1 end, Frequency),
    MaxEven = case maps:to_list(EvenFreq) of
        [] -> 0;
        _ -> lists:max(maps:to_list(EvenFreq))
    end,
    MaxOdd = case maps:to_list(OddFreq) of
        [] -> 0;
        _ -> lists:max(maps:to_list(OddFreq))
    end,
    MaxEven - MaxOdd.