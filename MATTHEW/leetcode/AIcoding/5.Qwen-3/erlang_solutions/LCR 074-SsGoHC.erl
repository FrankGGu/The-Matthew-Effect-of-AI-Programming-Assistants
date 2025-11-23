-module(merge_intervals).
-export([merge/1]).

merge([]) -> [];
merge(Intervals) ->
    Sorted = lists:sort(Intervals),
    merge(Sorted, []).

merge([], Result) ->
    lists:reverse(Result);
merge([[] | _], Result) ->
    lists:reverse(Result);
merge([[Start, End] | Rest], Result) ->
    case Result of
        [] ->
            merge(Rest, [[Start, End]]);
        [[RStart, REnd] | _] when Start > REnd ->
            merge(Rest, [[Start, End] | Result]);
        [[RStart, REnd] | Tail] ->
            NewEnd = max(End, REnd),
            merge(Rest, [[RStart, NewEnd] | Tail])
    end.