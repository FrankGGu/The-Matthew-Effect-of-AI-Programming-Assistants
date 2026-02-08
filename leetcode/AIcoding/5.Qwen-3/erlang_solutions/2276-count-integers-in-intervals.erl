-module(solution).
-export([initialize/0, add/2, size/1]).

initialize() ->
    {[], 0}.

add(_Interval, State) ->
    {Intervals, Count} = State,
    [Start, End] = _Interval,
    NewIntervals = insert_interval(Intervals, Start, End),
    {NewIntervals, Count + (End - Start + 1)}.

size(State) ->
    {_Intervals, Count} = State,
    Count.

insert_interval([], Start, End) ->
    [{Start, End}];
insert_interval([{S, E} | Rest], Start, End) when End < S ->
    [{Start, End}, {S, E} | Rest];
insert_interval([{S, E} | Rest], Start, End) when Start > E ->
    [{S, E} | insert_interval(Rest, Start, End)];
insert_interval([{S, E} | Rest], Start, End) ->
    NewStart = min(S, Start),
    NewEnd = max(E, End),
    [ {NewStart, NewEnd} | merge_intervals(Rest, NewStart, NewEnd) ].

merge_intervals([], _, _) ->
    [];
merge_intervals([{S, E} | Rest], NewStart, NewEnd) when E < NewStart ->
    [{S, E} | merge_intervals(Rest, NewStart, NewEnd)];
merge_intervals([{S, E} | Rest], NewStart, NewEnd) when S > NewEnd ->
    [{NewStart, NewEnd}, {S, E} | Rest];
merge_intervals([{S, E} | Rest], NewStart, NewEnd) ->
    NewStart2 = min(S, NewStart),
    NewEnd2 = max(E, NewEnd),
    merge_intervals(Rest, NewStart2, NewEnd2).