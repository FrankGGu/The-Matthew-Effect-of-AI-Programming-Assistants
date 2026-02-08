-module(solution).
-export([merge/1]).

merge(Intervals) ->
    Sorted = lists:sort(Intervals),
    merge(Sorted, []).

merge([], Result) ->
    lists:reverse(Result);
merge([[Start, End] | Rest], [Last | _] = Current) when Start > element(2, Last) ->
    merge(Rest, [[Start, End] | Current]);
merge([[Start, End] | Rest], [Last | _] = Current) ->
    NewLast = [element(1, Last), max(element(2, Last), End)],
    merge(Rest, [NewLast | tl(Current)]).

merge_intervals([]) -> [];
merge_intervals([Interval | Rest]) ->
    [Interval | merge_intervals(Rest)].

merge_intervals([], Result) ->
    lists:reverse(Result);
merge_intervals([Interval | Rest], Result) ->
    [Interval | merge_intervals(Rest, Result)].

merge_intervals([], _) -> [];

merge_groups([], Groups) ->
    Groups;
merge_groups([Interval | Rest], Groups) ->
    {Grouped, NotGrouped} = group_interval(Interval, Groups),
    merge_groups(Rest, Grouped ++ NotGrouped).

group_interval(_Interval, []) ->
    {[], [_Interval]};
group_interval([Start, End], [Group | Rest]) ->
    [GStart, GEnd] = Group,
    if
        End < GStart ->
            {[Group | Rest], [Start, End]};
        true ->
            {[[min(Start, GStart), max(End, GEnd)] | Rest], []}
    end.

divide(Intervals) ->
    Sorted = lists:sort(Intervals),
    merge_groups(Sorted, []).

merge_groups([], Groups) ->
    length(Groups);
merge_groups([Interval | Rest], Groups) ->
    {Grouped, NotGrouped} = group_interval(Interval, Groups),
    merge_groups(Rest, Grouped ++ NotGrouped).

solve(Intervals) ->
    divide(Intervals).