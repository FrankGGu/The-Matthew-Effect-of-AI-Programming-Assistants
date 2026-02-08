-module(most_visited_sector).
-export([most_visited_sector/2]).

most_visited_sector(N, Rounds) ->
    Counts = lists:seq(1, N),
    CountMap = maps:from_list([{Num, 0} || Num <- Counts]),
    update_counts(CountMap, Rounds),
    find_max(CountMap).

update_counts(CountMap, []) ->
    CountMap;
update_counts(CountMap, [Round | Rest]) ->
    {Start, End} = Round,
    update_segment(CountMap, Start, End),
    update_counts(CountMap, Rest).

update_segment(CountMap, Start, End) when Start =< End ->
    lists:foreach(fun(I) -> maps:update(I, fun(V) -> V + 1 end, CountMap) end, lists:seq(Start, End));
update_segment(CountMap, Start, End) ->
    lists:foreach(fun(I) -> maps:update(I, fun(V) -> V + 1 end, CountMap) end, lists:seq(Start, N)),
    lists:foreach(fun(I) -> maps:update(I, fun(V) -> V + 1 end, CountMap) end, lists:seq(1, End)).

find_max(CountMap) ->
    MaxVal = maps:fold(fun(_, V, Acc) -> max(Acc, V) end, -1, CountMap),
    lists:sort([Key || {Key, Val} <- maps:to_list(CountMap), Val == MaxVal]).