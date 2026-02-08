-module(solution).
-export([minimum_time/1]).

minimum_time(Locks) ->
    lists:sum([max(0, Lock - 1) || Lock <- Locks]).