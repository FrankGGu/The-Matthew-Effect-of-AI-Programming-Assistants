-module(minimum_time_break_locks_i).
-export([min_time_to_break_locks/1]).

min_time_to_break_locks(locks) ->
    min_time_to_break_locks(locks, 0).

min_time_to_break_locks([], Acc) ->
    Acc;
min_time_to_break_locks([H|T], Acc) ->
    min_time_to_break_locks(T, Acc + H).