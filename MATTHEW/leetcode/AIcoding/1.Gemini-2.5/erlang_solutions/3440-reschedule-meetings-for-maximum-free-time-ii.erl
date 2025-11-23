-module(solution).
-export([max_free_time/1]).

max_free_time(Meetings) ->
    SortedMeetings = lists:sort(fun([S1, _], [S2, _]) -> S1 =< S2 end, Meetings),
    MergedMeetings = merge_intervals(SortedMeetings),
    find_max_gap(MergedMeetings, 0).

merge_intervals([]) -> [];
merge_intervals([H | T]) ->
    merge_intervals_acc(T, [H]).

merge_intervals_acc([], Acc) ->
    lists:reverse(Acc);
merge_intervals_acc([[S2, E2] | T], [[S1, E1] | AccT]) when S2 =< E1 ->
    merge_intervals_acc(T, [[S1, max(E1, E2)] | AccT]);
merge_intervals_acc([H | T], Acc) ->
    merge_intervals_acc(T, [H | Acc]).

find_max_gap([], MaxGap) -> MaxGap;
find_max_gap([_] , MaxGap) -> MaxGap;
find_max_gap([[_, E1] , [S2, _] | T] , CurrentMaxGap) ->
    Gap = S2 - E1,
    find_max_gap([[S2, _] | T], max(CurrentMaxGap, Gap)).