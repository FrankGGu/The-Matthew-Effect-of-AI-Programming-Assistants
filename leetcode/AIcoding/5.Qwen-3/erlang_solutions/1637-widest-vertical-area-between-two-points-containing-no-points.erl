-module(widest_vertical_area).
-export([max_width_of_vertical_area/1]).

max_width_of_vertical_area(Points) ->
    Sorted = lists:sort([X || [X, _] <- Points]),
    max_width(Sorted, 0).

max_width([], Acc) ->
    Acc;
max_width([_], Acc) ->
    Acc;
max_width([H | [T | _] = Rest], Acc) ->
    Diff = T - H,
    max_width(Rest, erlang:max(Acc, Diff)).