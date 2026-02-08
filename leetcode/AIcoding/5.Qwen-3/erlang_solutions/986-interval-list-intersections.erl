-module(interval_list_intersections).
-export([interval_intersection/2]).

interval_intersection(Interval1, Interval2) ->
    interval_intersection(Interval1, Interval2, []).

interval_intersection([], _, Acc) ->
    lists:reverse(Acc);
interval_intersection(_, [], Acc) ->
    lists:reverse(Acc);
interval_intersection([H1 | T1], [H2 | T2], Acc) ->
    {Start1, End1} = H1,
    {Start2, End2} = H2,
    Start = max(Start1, Start2),
    End = min(End1, End2),
    if
        Start =< End ->
            interval_intersection(T1, T2, [{Start, End} | Acc]);
        true ->
            if
                End1 < End2 ->
                    interval_intersection(T1, [H2 | T2], Acc);
                true ->
                    interval_intersection([H1 | T1], T2, Acc)
            end
    end.