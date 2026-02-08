-module(solution).
-export([insert/2]).

-spec insert(Intervals :: [[integer(), integer()]], NewInterval :: [integer(), integer()]) -> [[integer(), integer()]].
insert(Intervals, NewInterval) ->
    insert_intervals_helper(Intervals, NewInterval, []).

insert_intervals_helper([], NewInterval, Acc) ->
    lists:reverse([NewInterval | Acc]).
insert_intervals_helper([[HStart, HEnd] | T], [NStart, NEnd], Acc) when NEnd < HStart ->
    lists:reverse([NewInterval | Acc]) ++ [[HStart, HEnd] | T].
insert_intervals_helper([[HStart, HEnd] | T], [NStart, NEnd], Acc) when NStart > HEnd ->
    insert_intervals_helper(T, [NStart, NEnd], [[HStart, HEnd] | Acc]).
insert_intervals_helper([[HStart, HEnd] | T], [NStart, NEnd], Acc) ->
    MergedStart = min(NStart, HStart),
    MergedEnd = max(NEnd, HEnd),
    insert_intervals_helper(T, [MergedStart, MergedEnd], Acc).