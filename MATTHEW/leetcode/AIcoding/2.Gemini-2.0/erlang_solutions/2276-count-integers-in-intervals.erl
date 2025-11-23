-module(count_intervals).
-export([new/0, addInterval/3, countOverall/1]).

-record(state, {intervals = []}).

new() ->
    #state{}.

addInterval(L, R, State) ->
    addInterval(L, R, State#state.intervals, []).

addInterval(L, R, [], Acc) ->
    State = #state{intervals = lists:sort(Acc ++ [{L, R}])},
    mergeOverlapping(State#state.intervals, []);

addInterval(L, R, [Interval = {IL, IR} | Rest], Acc) ->
    case true of
        R < IL ->
            State = #state{intervals = lists:sort(Acc ++ [{L, R}] ++ [Interval | Rest])},
            mergeOverlapping(State#state.intervals, []);
        L > IR ->
            addInterval(L, R, Rest, Acc ++ [Interval]);
        true ->
            NewL = min(L, IL),
            NewR = max(R, IR),
            addInterval(NewL, NewR, Rest, Acc)
    end.

mergeOverlapping(Intervals, Acc) ->
    mergeOverlapping(lists:sort(Intervals), Acc, []).

mergeOverlapping([], Acc, Merged) ->
    #state{intervals = lists:reverse(Merged ++ Acc)};
mergeOverlapping([Interval = {L, R}], Acc, Merged) ->
    #state{intervals = lists:reverse(Merged ++ Acc ++ [Interval])};
mergeOverlapping([{L1, R1}, {L2, R2} | Rest], Acc, Merged) ->
    case true of
        R1 >= L2 ->
            mergeOverlapping([{L1, max(R1, R2)} | Rest], Acc, Merged);
        true ->
            mergeOverlapping([{L2, R2} | Rest], Acc ++ [{L1, R1}], Merged)
    end.

countOverall(State) ->
    countOverall(State#state.intervals, 0).

countOverall([], Acc) ->
    Acc;
countOverall([{L, R} | Rest], Acc) ->
    countOverall(Rest, Acc + (R - L + 1)).