-module(maximum_events_ii).
-export([max_value/2]).

max_value(Events, K) ->
    EventsSorted = lists:sort(fun({S1, _, _}, {S2, _, _}) -> S1 < S2 end, Events),
    memo(EventsSorted, 0, K, []).

memo([], _, _, Memo) ->
    lists:max([0 | [Value || {_Idx, Value} <- Memo]]).
memo(_, _, 0, Memo) ->
    lists:max([0 | [Value || {_Idx, Value} <- Memo]]).
memo(Events, Idx, K, Memo) ->
    case lists:keyfind(Idx * K + K, 1, Memo) of
        false ->
            {Start, End, Value} = lists:nth(1, Events),
            NextEvents = lists:dropwhile(fun({S, _, _}) -> S =< End end, tl(Events)),
            NextIdx = Idx + 1,
            Attend = Value + memo(NextEvents, NextIdx, K - 1, Memo),
            Skip = memo(tl(Events), Idx, K, Memo),
            Result = max(Attend, Skip),
            memo(tl(Events), Idx, K, [{Idx * K + K, Result} | Memo]);
        {_, Value} ->
            Value
    end.