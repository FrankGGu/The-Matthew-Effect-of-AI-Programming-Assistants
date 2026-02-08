-spec insert(Intervals :: [[integer()]], NewInterval :: [integer()]) -> [[integer()]].
insert(Intervals, NewInterval) ->
    insert(Intervals, NewInterval, []).

insert([], [Start, End], Acc) -> lists:reverse([[Start, End] | Acc]);
insert([[IStart, IEnd] | Rest], [Start, End], Acc) when End < IStart ->
    insert(Rest, [Start, End], [[IStart, IEnd] | Acc]);
insert([[IStart, IEnd] | Rest], [Start, End], Acc) when Start > IEnd ->
    insert(Rest, [Start, End], [[IStart, IEnd] | Acc]);
insert([[IStart, IEnd] | Rest], [Start, End], Acc) ->
    insert(Rest, [min(IStart, Start), max(IEnd, End)], Acc).

