-module(solution).
-export([max_total_height/1]).

max_total_height(Towers) ->
    Sorted = lists:sort(Towers),
    max_total_height(Sorted, 0, 0).

max_total_height([], _, Acc) ->
    Acc;
max_total_height([H | T], Prev, Acc) ->
    if
        H > Prev ->
            max_total_height(T, H, Acc + H);
        true ->
            max_total_height(T, Prev, Acc)
    end.