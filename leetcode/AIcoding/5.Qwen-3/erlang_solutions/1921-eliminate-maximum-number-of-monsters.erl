-module(eliminate_max_monsters).
-export([eliminateMaximum/2]).

eliminateMaximum(Positions, Speeds) ->
    Times = lists:zipwith(fun(P, S) -> (P / S) end, Positions, Speeds),
    SortedTimes = lists:sort(Times),
    eliminateMaximum(SortedTimes, 0, 0).

eliminateMaximum([], _, Count) ->
    Count;
eliminateMaximum([T | Rest], Time, Count) ->
    if
        T > Time ->
            eliminateMaximum(Rest, Time + 1, Count + 1);
        true ->
            Count
    end.