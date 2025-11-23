-module(solution).
-export([min_time_to_break_locks/2]).

min_time_to_break_locks(Locks, Time) ->
    lists:sum(lists:map(fun(Lock) -> ceil(Lock / Time) end, Locks)).