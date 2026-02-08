-module(minimum_time_to_type).
-export([min_time_to_type/1]).

min_time_to_type(Word) ->
    min_time_to_type(Word, $a, 0).

min_time_to_type([], _, Acc) ->
    Acc;
min_time_to_type([H|T], Current, Acc) ->
    Diff = abs(H - Current),
    Distance = min(Diff, 26 - Diff),
    min_time_to_type(T, H, Acc + Distance + 1).