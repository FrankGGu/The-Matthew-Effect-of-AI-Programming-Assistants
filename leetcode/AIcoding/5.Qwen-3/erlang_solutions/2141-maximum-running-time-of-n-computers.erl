-module(maximum_running_time).
-export([max_run_time/2]).

max_run_time(Batteries, N) ->
    lists:sort(Batteries),
    max_run_time(Batteries, N, 0).

max_run_time([], _, Acc) ->
    Acc;
max_run_time([B | Bs], N, Acc) ->
    case length(Bs) + 1 >= N of
        true ->
            max_run_time(Bs, N, Acc + B);
        false ->
            max_run_time(Bs, N, Acc)
    end.