-module(solution).
-export([max_run_time/2]).

max_run_time(N, batteries) ->
    TotalEnergy = lists:sum(batteries),
    MaxTime = TotalEnergy div N,
    MaxTime.