-module(merge_intervals).
-export([merge/1]).

merge([]) -> [];
merge(Intervals) ->
    Sorted = lists:sort(fun(A, B) -> hd(A) =< hd(B) end, Intervals),
    merge(Sorted, []).

merge([], Result) -> lists:reverse(Result);
merge([[] | _], Result) -> lists:reverse(Result);
merge([Current | Rest], Result) ->
    [Start | [End | _]] = Current,
    case Result of
        [] ->
            merge(Rest, [Current]);
        [[RStart | [REnd | _]] | _] when End < RStart ->
            merge(Rest, [Current | Result]);
        _ ->
            [RStart | [REnd | _]] = hd(Result),
            NewInterval = [RStart, max(REnd, End)],
            merge(Rest, [NewInterval | tl(Result)])
    end.